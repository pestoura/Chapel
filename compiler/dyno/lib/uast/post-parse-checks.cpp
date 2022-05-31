/*
 * Copyright 2020-2022 Hewlett Packard Enterprise Development LP
 * Copyright 2004-2019 Cray Inc.
 * Other additional copyright holders may be indicated within.
 *
 * The entirety of this work is licensed under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "chpl/uast/all-uast.h"
#include <vector>

namespace {
  using namespace chpl;
  using namespace uast;

  struct Visitor {
    std::set<UniqueString> exportedFnNames_;
    std::vector<const AstNode*> parents_;
    Context* context_;
    Builder& builder_;

    Visitor(Context* context, Builder& builder)
      : context_(context),
        builder_(builder) {
    }

    // Create and store an error in the builder (convenience overloads for
    // both errors and warnings below). This factory function is provided
    // because errors pinning on freshly parsed AST cannot be stored in
    // the context at this point.
    void report(const AstNode* node, ErrorMessage::Kind kind,
                const char* fmt,
                va_list vl);
    void error(const AstNode* node, const char* fmt, ...);
    void warn(const AstNode* node, const char* fmt, ...);

    // Get the i'th parent of the currently visited node. For example, for
    // the call 'parent(0)', return the most immediate parent.
    const AstNode* parent(int depth=0) const;

    // Search ancestors for the closest parent with a given tag. If found,
    // then 'last' will contain the penultimate parent in the path.
    const AstNode* searchParents(AstTag tag, const AstNode** last);

    // Wrapper around 'node->dispatch'.
    void check(const AstNode* node);

    // Called in the visitor loop to check for duplicate exported names.
    void maybeCheckExportedName(const NamedDecl* node);

    // Checks.
    void checkDomainTypeQueryUsage(const TypeQuery* node);
    void checkNoDuplicateNamedArguments(const FnCall* node);
    void checkClassDecorators(const Call* node);
    void checkExplicitDeinitCalls(const Call* node);
    void checkPrivateDecls(const Decl* node);
    void checkConstVarNoInit(const Variable* node);
    void checkConfigVar(const Variable* node);
    void checkExportVar(const Variable* node);
    void checkEmptyProcedureBody(const Function* node);
    void checkExternProcedure(const Function* node);
    void checkExportProcedure(const Function* node);
    void checkParenlessMethods(const Function* node);
    void checkProcedureFormalsAgainstRetType(const Function* node);
    void checkFunctionReturnsYields(const Function* node);
    void checkReturnHelper(const Return* node);
    void checkYieldHelper(const Yield* node);
    void checkImplicitModuleSameName(const Module* node);
    void checkIncludeModuleStrictName(const Module* node);
    void checkModuleReturnsYields(const Module* node);
    void checkPointlessUse(const Use* node);

    // Warnings.
    void warnUnstableUnions(const Union* node);
    void warnUnstableLeadingUnderscores(const NamedDecl* node);

    // Visitors.
    void visit(const AstNode* node);
    void visit(const TypeQuery* node);
    void visit(const FnCall* node);
  };

  void Visitor::report(const AstNode* node, ErrorMessage::Kind kind,
                       const char* fmt,
                       va_list vl) {
    auto loc = builder_.getLocation(node);
    auto err = ErrorMessage::vbuild(node->id(), loc, kind, fmt, vl);
    builder_.addError(std::move(err));
  }

  void Visitor::error(const AstNode* node, const char* fmt, ...) {
    va_list vl;
    va_start(vl, fmt);
    report(node, ErrorMessage::ERROR, fmt, vl);
  }

  void Visitor::warn(const AstNode* node, const char* fmt, ...) {
    va_list vl;
    va_start(vl, fmt);
    report(node, ErrorMessage::WARNING, fmt, vl);
  }

  const AstNode* Visitor::parent(int depth) const {
    assert(depth >= 0); 
    if (depth >= parents_.size()) return nullptr;
    int idx = parents_.size() - depth - 1;
    assert(idx >= 0);
    auto ret = parents_[idx];
    return ret;
  }

  const AstNode*
  Visitor::searchParents(AstTag tag, const AstNode** last) {
    const AstNode* ret = nullptr;
    const AstNode* lastInWalk = nullptr;

    for (int i = parents_.size() - 1; i >= 0; i--) {
      auto ast = parents_[i];
      if (ast->tag() == tag) {
        ret = ast;
        break;
      } else {
        lastInWalk = ast;
      }
    }

    if (last) *last = lastInWalk;
    return ret;
  }

  // Simple pre-order traversal. Also maintain a chain of parents.
  void Visitor::check(const AstNode* node) {
    if (auto named = node->toNamedDecl()) maybeCheckExportedName(named);
    node->dispatch<void>(*this);
    parents_.push_back(node);
    for (auto child : node->children()) check(child);
    parents_.pop_back();
  }

  // TODO
  void Visitor::maybeCheckExportedName(const NamedDecl* node) {
    (void) node;
  }

  void Visitor::checkDomainTypeQueryUsage(const TypeQuery* node) {
    if (!parent(0) || !parent(1)) return;

    // Only care about the form '[?d]', leave otherwise.
    auto dom = parent(0)->toDomain();
    auto bkt = parent(1)->toBracketLoop();
    if (!dom || !bkt || (dom != bkt->iterand())) return;

    const AstNode* lastInWalk = nullptr;
    bool doEmitError = true;

    // If we are descended from the formal's type expression, OK!
    if (auto foundFormal = searchParents(asttags::Formal, &lastInWalk)) {
      auto formal = foundFormal->toFormal();
      assert(formal);
      if (lastInWalk == formal->typeExpression()) doEmitError = false;
    }

    if (doEmitError) {
      error(node, "Domain query expressions may currently "
                  "only be used in formal argument types");
    }
  }

  // TODO...
  void Visitor::checkNoDuplicateNamedArguments(const FnCall* node) {
    (void) node;
  }

  void Visitor::checkClassDecorators(const Call* node) {
    (void) node;
  }

  void Visitor::checkExplicitDeinitCalls(const Call* node) {
    (void) node;
  }

  void Visitor::checkPrivateDecls(const Decl* node) {
    (void) node;
  }

  void Visitor::checkConstVarNoInit(const Variable* node) {
    (void) node;
  }

  void Visitor::checkConfigVar(const Variable* node) {
    (void) node;
  }

  void Visitor::checkExportVar(const Variable* node) {
    (void) node;
  }

  void Visitor::checkEmptyProcedureBody(const Function* node) {
    (void) node;
  }

  void Visitor::checkExternProcedure(const Function* node) {
    (void) node;
  }

  void Visitor::checkExportProcedure(const Function* node) {
    (void) node;
  }

  void Visitor::checkParenlessMethods(const Function* node) {
    (void) node;
  }

  void Visitor::checkProcedureFormalsAgainstRetType(const Function* node) {
    (void) node;
  }

  void Visitor::checkFunctionReturnsYields(const Function* node) {
    (void) node;
  }

  void Visitor::checkReturnHelper(const Return* node) {
    (void) node;
  }

  void Visitor::checkYieldHelper(const Yield* node) {
    (void) node;
  }

  void Visitor::checkImplicitModuleSameName(const Module* node) {
    (void) node;
  }

  void Visitor::checkIncludeModuleStrictName(const Module* node) {
    (void) node;
  }

  void Visitor::checkModuleReturnsYields(const Module* node) {
    (void) node;
  }

  void Visitor::checkPointlessUse(const Use* node) {
    (void) node;
  }

  void Visitor::warnUnstableUnions(const Union* node) {
    (void) node;
  }

  void Visitor::warnUnstableLeadingUnderscores(const NamedDecl* node) {
    (void) node;
  }

  // Do nothing.
  void Visitor::visit(const AstNode* node) {}

  void Visitor::visit(const FnCall* node) {
    checkNoDuplicateNamedArguments(node);
  }

  void Visitor::visit(const TypeQuery* node) {
    checkDomainTypeQueryUsage(node);
  }

} // end anonymous namespace

namespace chpl {
namespace uast {

void Builder::postParseChecks() {
  auto visitor = Visitor(context_, *this);
  for (auto& ast : topLevelExpressions_) {
    if (ast->isComment()) continue;
    visitor.check(ast.get());
  }
}

} // end namespace uast
} // end namespace chpl

