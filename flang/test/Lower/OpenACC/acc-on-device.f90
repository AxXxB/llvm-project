! This test checks lowering of the OpenACC acc_on_device intrinsic.

! RUN: bbc -fopenacc -emit-hlfir %s -o - | FileCheck %s

subroutine acc_on_device_test
  use openacc
  implicit none
  logical :: on_host

  on_host = acc_on_device(acc_device_host)
!CHECK: [[HOST:%.*]] = fir.load %{{.*}} : !fir.ref<i32>
!CHECK: acc.on_device [[HOST]] : i32 -> i1
!CHECK-NOT: fir.call @acc_on_device
end subroutine acc_on_device_test
