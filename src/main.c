/*
 * main.c
 *
 * Author: Gonzalo G. Fernandez
 */

#include <stdio.h>

#include "xparameters.h"
#include "xgpio.h"
#include "my_pwm.h"
#include "qencoder.h"

//====================================================

int main (void)
{

   XGpio dip;
   int dip_check;
   int pwm_freq = 100, pwm_duty = 50;
   int qencoder_position, qencoder_dir;

   xil_printf("-- Start of the Program --\r\n");

   XGpio_Initialize(&dip, XPAR_SWITCHES_DEVICE_ID);
   XGpio_SetDataDirection(&dip, 1, 0xffffffff);

   // enable qencoder
   QENCODER_mWriteReg(XPAR_QENCODER_0_S_AXI_BASEADDR, QENCODER_S_AXI_SLV_REG0_OFFSET, 0xFFFFFFFF);

   while (1)
   {
	  dip_check = XGpio_DiscreteRead(&dip, 1);
//	  xil_printf("\r\nDIP Switch Status %x\r\n", dip_check);


	  // configure PWM
	  if (dip_check == 1)
	  {
		  xil_printf("DIP Switch 01: Enable PWM\r\n");
		  xil_printf("\r\nEnter PWM frequency: ");
		  scanf("%d", &pwm_freq);
		  xil_printf("\r\nEnter PWM duty cycle: ");
		  scanf("%d", &pwm_duty);
		  xil_printf("\r\nNew PWM config:\r\n- FREQ: %d\r\n- DUTY: %d", pwm_freq, pwm_duty);
		  MY_PWM_mWriteReg(XPAR_MY_PWM_0_S_AXI_BASEADDR, MY_PWM_S_AXI_SLV_REG2_OFFSET, 0xFFFFFFFF);
		  MY_PWM_mWriteReg(XPAR_MY_PWM_0_S_AXI_BASEADDR, MY_PWM_S_AXI_SLV_REG0_OFFSET, pwm_freq);
		  MY_PWM_mWriteReg(XPAR_MY_PWM_0_S_AXI_BASEADDR, MY_PWM_S_AXI_SLV_REG1_OFFSET, pwm_duty);
	  }
	  // read encoder
	  else if (dip_check == 0)
	  {
		  xil_printf("DIP Switch 10: Enable PWM\r\n");
		  qencoder_position = QENCODER_mReadReg(XPAR_QENCODER_0_S_AXI_BASEADDR, QENCODER_S_AXI_SLV_REG1_OFFSET);
		  qencoder_dir = QENCODER_mReadReg(XPAR_QENCODER_0_S_AXI_BASEADDR, QENCODER_S_AXI_SLV_REG2_OFFSET);
		  xil_printf("Encoder Position %d\r\n", qencoder_position);
		  xil_printf("Encoder Direction %d\r\n", qencoder_dir);
	  }
	  else
	  {
//		  xil_printf("DIP Switch: Disable PWM\r\n");
		  MY_PWM_mWriteReg(XPAR_MY_PWM_0_S_AXI_BASEADDR, MY_PWM_S_AXI_SLV_REG2_OFFSET, 0);
		  MY_PWM_mWriteReg(XPAR_MY_PWM_0_S_AXI_BASEADDR, MY_PWM_S_AXI_SLV_REG0_OFFSET, 0);
		  MY_PWM_mWriteReg(XPAR_MY_PWM_0_S_AXI_BASEADDR, MY_PWM_S_AXI_SLV_REG1_OFFSET, 0);
	  }

	  sleep(1);
   }
}
