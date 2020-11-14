; RUN: llc < %s -march=tvm | FileCheck %s

target datalayout = "E-S257-i1:257:257-i8:257:257-i16:257:257-i32:257:257-i64:257:257-i257:257:257-p:257:257-a:257:257"
target triple = "tvm"

define i257 @baz() {
; CHECK-LABEL: baz
entry:
  ret i257 undef
}

define void @phi() {
; CHECK-LABEL: phi
entry:
  br label %loop
loop:
  %0 = phi i257* [ undef, %entry ], [ %1, %loop ]
  %1 = getelementptr i257, i257* %0, i257 3
  br label %loop
}

define void @two1() {
  call void @two(i257 12345, i257 undef)
  ret void
}
define void @two2() {
  call void @two(i257 undef, i257 12345)
  ret void
}
define void @two3() {
  call void @two(i257 undef, i257 undef)
  ret void
}
declare void @two(i257, i257)

define void @three1() {
  call void @three(i257 12345, i257 12345, i257 undef)
  ret void
}
define void @three2() {
  call void @three(i257 12345, i257 undef, i257 12345)
  ret void
}
define void @three3() {
  call void @three(i257 12345, i257 undef, i257 undef)
  ret void
}
define void @three4() {
  call void @three(i257 undef, i257 12345, i257 12345)
  ret void
}
define void @three5() {
  call void @three(i257 undef, i257 12345, i257 undef)
  ret void
}
define void @three6() {
  call void @three(i257 undef, i257 undef, i257 12345)
  ret void
}
define void @three7() {
  call void @three(i257 undef, i257 undef, i257 undef)
  ret void
}
declare void @three(i257, i257, i257)

define void @four1() {
  call void @four(i257 undef, i257 undef, i257 undef, i257 undef)
  ret void
}
define void @four2() {
  call void @four(i257 undef, i257 12345, i257 12345, i257 12345)
  ret void
}
define void @four3() {
  call void @four(i257 12345, i257 12345, i257 12345, i257 undef)
  ret void
}
declare void @four(i257, i257, i257, i257)

; CHECK-LABEL: sti
define builder @sti(builder %builder) {
; CHECK: ZERO
; CHECK: STIR 5
  %builder.1 = call builder @llvm.tvm.sti(i257 undef, builder %builder, i257 5)
  ret builder %builder.1
}

; CHECK-LABEL: stref
define builder @stref(builder %builder) {
; CHECK: NEWC
; CHECK: ENDC
; CHECK: SWAP
; CHECK: STREF
  %builder.1 = call builder @llvm.tvm.stref(cell undef, builder %builder)
  ret builder %builder.1
}

; CHECK-LABEL: stslice
define builder @stslice(builder %builder) {
; CHECK: NEWC
; CHECK: ENDC
; CHECK: CTOS
; CHECK: SWAP
; CHECK: STSLICE
  %builder.1 = call builder @llvm.tvm.stslice(slice undef, builder %builder)
  ret builder %builder.1
}

declare builder @llvm.tvm.sti(i257 %value, builder %builder, i257 %size)
declare builder @llvm.tvm.stu(i257 %value, builder %builder, i257 %size)
declare builder @llvm.tvm.stref(cell %value, builder %builder)
declare builder @llvm.tvm.stslice(slice %value, builder %builder)
