; RUN: llc < %s -march=tvm 
; ModuleID = 'while_for_for.c'
source_filename = "while_for_for.c"
target datalayout = "E-S257-i1:257:257-i8:257:257-i16:257:257-i32:257:257-i64:257:257-i257:257:257-p:257:257-a:257:257"
target triple = "tvm"

; Function Attrs: nounwind
define dso_local i257 @func(i257 %n1, i257 %n2, i257 %n3) local_unnamed_addr #0 {
entry:
  %cmp28 = icmp sgt i257 %n1, 0
  br i1 %cmp28, label %for.cond.preheader.lr.ph, label %while.end

for.cond.preheader.lr.ph:                         ; preds = %entry
  %cmp124 = icmp sgt i257 %n2, 0
  %cmp321 = icmp sgt i257 %n3, 0
  br i1 %cmp124, label %for.cond.preheader.us, label %while.end

for.cond.preheader.us:                            ; preds = %for.cond.preheader.lr.ph, %for.cond.for.cond.cleanup_crit_edge.us
  %v1.030.us = phi i257 [ %inc9.us, %for.cond.for.cond.cleanup_crit_edge.us ], [ 0, %for.cond.preheader.lr.ph ]
  %res.029.us = phi i257 [ %split27.us, %for.cond.for.cond.cleanup_crit_edge.us ], [ 0, %for.cond.preheader.lr.ph ]
  br i1 %cmp321, label %for.cond2.preheader.us.us, label %for.cond.for.cond.cleanup_crit_edge.us

for.cond.for.cond.cleanup_crit_edge.us:           ; preds = %for.cond2.for.cond.cleanup4_crit_edge.us.us, %for.cond.preheader.us
  %split27.us = phi i257 [ %res.029.us, %for.cond.preheader.us ], [ %add.us.us, %for.cond2.for.cond.cleanup4_crit_edge.us.us ]
  %inc9.us = add nuw nsw i257 %v1.030.us, 1
  %cmp.us = icmp slt i257 %inc9.us, %n1
  br i1 %cmp.us, label %for.cond.preheader.us, label %while.end

for.cond2.preheader.us.us:                        ; preds = %for.cond.preheader.us, %for.cond2.for.cond.cleanup4_crit_edge.us.us
  %v2.026.us.us = phi i257 [ %inc7.us.us, %for.cond2.for.cond.cleanup4_crit_edge.us.us ], [ 0, %for.cond.preheader.us ]
  %res.125.us.us = phi i257 [ %add.us.us, %for.cond2.for.cond.cleanup4_crit_edge.us.us ], [ %res.029.us, %for.cond.preheader.us ]
  br label %for.body5.us.us

for.cond2.for.cond.cleanup4_crit_edge.us.us:      ; preds = %for.body5.us.us
  %inc7.us.us = add nuw nsw i257 %v2.026.us.us, 1
  %cmp1.us.us = icmp slt i257 %inc7.us.us, %n2
  br i1 %cmp1.us.us, label %for.cond2.preheader.us.us, label %for.cond.for.cond.cleanup_crit_edge.us

for.body5.us.us:                                  ; preds = %for.body5.us.us, %for.cond2.preheader.us.us
  %v3.023.us.us = phi i257 [ 0, %for.cond2.preheader.us.us ], [ %inc.us.us, %for.body5.us.us ]
  %res.222.us.us = phi i257 [ %res.125.us.us, %for.cond2.preheader.us.us ], [ %add.us.us, %for.body5.us.us ]
  %call.us.us = tail call i257 @foo(i257 %v1.030.us, i257 %v2.026.us.us, i257 %v3.023.us.us) #2
  %add.us.us = add nsw i257 %call.us.us, %res.222.us.us
  %inc.us.us = add nuw nsw i257 %v3.023.us.us, 1
  %cmp3.us.us = icmp slt i257 %inc.us.us, %n3
  br i1 %cmp3.us.us, label %for.body5.us.us, label %for.cond2.for.cond.cleanup4_crit_edge.us.us

while.end:                                        ; preds = %for.cond.for.cond.cleanup_crit_edge.us, %for.cond.preheader.lr.ph, %entry
  %res.0.lcssa = phi i257 [ 0, %entry ], [ 0, %for.cond.preheader.lr.ph ], [ %split27.us, %for.cond.for.cond.cleanup_crit_edge.us ]
  ret i257 %res.0.lcssa
}

declare dso_local i257 @foo(i257, i257, i257) local_unnamed_addr #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 1}
!1 = !{!"clang version 7.0.0 "}
