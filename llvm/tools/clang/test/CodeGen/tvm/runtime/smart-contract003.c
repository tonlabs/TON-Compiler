// RUN: %clang -O3 -S -c -target tvm -Dget_SmartContractInfo=get_SmartContractInfoEmul -I %S/../../../../../../../samples/sdk-prototype %s -o %t
// RUN: %clang -O3 -S -c -target tvm %S/../../../../../../../samples/sdk-prototype/ton-sdk/messages.c -o %t.messages
// RUN: %clang -O3 -S -c -target tvm %S/../../../../../../../samples/sdk-prototype/ton-sdk/tvm.c -o %t.tvm
// RUN: cat %t %t.messages %t.tvm > %t.combined
// RUN: tvm-testrun --no-trace --entry test --stdlibc-path %S/../../../../../../../stdlib/stdlib_c.tvm < %t.combined | FileCheck %s

#include <wallet.c>
#include <ton-sdk/tvm.h>
#include <ton-sdk/smart-contract-info.h>

SmartContractInfo get_SmartContractInfoEmul() {
  SmartContractInfo info;

  info.actions = 1;
  info.msgs_sent = 1;
  info.unixtime = 0;
  info.block_lt = 0;
  info.trans_lt = 0;
  info.rand_seed = 0;
  info.balance_remaining.grams.amount.value = 100;
  info.balance_remaining.other = 0;
  info.myself.anycast = 1;
  info.myself.workchain_id = 0;
  info.myself.address = 0xaaaa; 

  return info;
}

void test()
{
//CHECK-NOT: custom error
//CHECK: Output actions:
//CHECK-NEXT: ----------------
//CHECK-NEXT: Action(SendMsg):
//CHECK-NEXT: message header
//CHECK-NEXT: ihr_disabled: false
//CHECK-NEXT: bounce      : false
//CHECK-NEXT: bounced     : false
//CHECK-NEXT: source      : 0:0000000000000000000000000000000000000000000000000000000080000001
//CHECK-NEXT: destination : 0:0000000000000000000000000000000000000000000000000000000080000001
//CHECK-NEXT: value       : CurrencyCollection: Grams vui16[len = 1, value = 3], other curencies:
//CHECK-NEXT: count: 0
//CHECK-NEXT: ihr_fee     : vui16[len = 0, value = 0]
//CHECK-NEXT: fwd_fee     : vui16[len = 0, value = 0]
//CHECK-NEXT: created_lt  : 0
//CHECK-NEXT: created_at  : 0
//CHECK-NEXT: init  : None
//CHECK-NEXT: body : bits: 15 refs: 0 data: 0001_
//CHECK-NEXT: body_hex: 0000
//CHECK-EMPTY:
//CHECK-NEXT: TEST COMPLETED
  constructor_Impl();
  set_tx_limit_Impl(3);

  unsigned result = transfer_Impl(0x80000001, 3);
  tvm_assert (result == TransferStatus_Success, 13);

  result = transfer_Impl(0x80000001, 4);
  tvm_assert (result == TransferStatus_TxLimitExceeded, 13);

  result = transfer_Impl(0x80000001, 101);
  tvm_assert (result == TransferStatus_NotEnoughMoney, 13);
}
