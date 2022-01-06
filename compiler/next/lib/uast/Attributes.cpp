/*
 * Copyright 2022 Hewlett Packard Enterprise Development LP
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

#include "chpl/uast/Attributes.h"

#include "chpl/uast/Builder.h"

namespace chpl {
namespace uast {


owned<Attributes> Attributes::build(Builder* builder, Location loc,
                                    std::set<PragmaTag> pragmas,
                                    bool isDeprecated,
                                    UniqueString deprecationMessage) {
  for (auto tag : pragmas) {
    assert(tag >= 0 && tag < NUM_KNOWN_PRAGMAS);
  }

  Attributes* ret = new Attributes(std::move(pragmas), isDeprecated,
                                   deprecationMessage);
  builder->noteLocation(ret, loc);
  return toOwned(ret);
}


} // namespace uast
} // namespace chpl
