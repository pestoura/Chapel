add_llvm_library(LLVMAnalysis
  AliasAnalysis.cpp
  AliasAnalysisEvaluator.cpp
  AliasAnalysisSummary.cpp
  AliasSetTracker.cpp
  Analysis.cpp
  AssumptionCache.cpp
  BasicAliasAnalysis.cpp
  BlockFrequencyInfo.cpp
  BlockFrequencyInfoImpl.cpp
  BranchProbabilityInfo.cpp
  CFG.cpp
  CFGPrinter.cpp
  CFLAndersAliasAnalysis.cpp
  CFLSteensAliasAnalysis.cpp
  CGSCCPassManager.cpp
  CallGraph.cpp
  CallGraphSCCPass.cpp
  CallPrinter.cpp
  CaptureTracking.cpp
  CmpInstAnalysis.cpp
  CostModel.cpp
  CodeMetrics.cpp
  ConstantFolding.cpp
  Delinearization.cpp
  DemandedBits.cpp
  DependenceAnalysis.cpp
  DivergenceAnalysis.cpp
  DomPrinter.cpp
  DominanceFrontier.cpp
  EHPersonalities.cpp
  GlobalsModRef.cpp
  IVUsers.cpp
  IndirectCallPromotionAnalysis.cpp
  InlineCost.cpp
  InstCount.cpp
  InstructionSimplify.cpp
  Interval.cpp
  IntervalPartition.cpp
  IteratedDominanceFrontier.cpp
  LazyBranchProbabilityInfo.cpp
  LazyBlockFrequencyInfo.cpp
  LazyCallGraph.cpp
  LazyValueInfo.cpp
  Lint.cpp
  Loads.cpp
  LoopAccessAnalysis.cpp
  LoopAnalysisManager.cpp
  LoopUnrollAnalyzer.cpp
  LoopInfo.cpp
  LoopPass.cpp
  MemDepPrinter.cpp
  MemDerefPrinter.cpp
  MemoryBuiltins.cpp
  MemoryDependenceAnalysis.cpp
  MemoryLocation.cpp
  MemorySSA.cpp
  MemorySSAUpdater.cpp
  ModuleDebugInfoPrinter.cpp
  ModuleSummaryAnalysis.cpp
  MustExecute.cpp
  ObjCARCAliasAnalysis.cpp
  ObjCARCAnalysisUtils.cpp
  ObjCARCInstKind.cpp
  OptimizationRemarkEmitter.cpp
  OrderedBasicBlock.cpp
  PHITransAddr.cpp
  PhiValues.cpp
  PostDominators.cpp
  ProfileSummaryInfo.cpp
  PtrUseVisitor.cpp
  RegionInfo.cpp
  RegionPass.cpp
  RegionPrinter.cpp
  ScalarEvolution.cpp
  ScalarEvolutionAliasAnalysis.cpp
  ScalarEvolutionExpander.cpp
  ScalarEvolutionNormalization.cpp
  SyntheticCountsUtils.cpp
  TargetLibraryInfo.cpp
  TargetTransformInfo.cpp
  Trace.cpp
  TypeBasedAliasAnalysis.cpp
  TypeMetadataUtils.cpp
  ScopedNoAliasAA.cpp
  ValueLattice.cpp
  ValueLatticeUtils.cpp
  ValueTracking.cpp
  VectorUtils.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/Analysis

  DEPENDS
  intrinsics_gen
  )