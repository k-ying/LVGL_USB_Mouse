/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "dma.h"
#include "spi.h"
#include "tim.h"
#include "usart.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "stdio.h"
#include "st7735.h"
#include "fonts.h"
#include "lvgl.h"
#include "lv_port_disp.h"
#include "lv_port_indev.h"
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */
int fputc(int ch, FILE *f)
{
    HAL_UART_Transmit(&huart1, (uint8_t *)&ch, 1, 0xFFFF);//重定向printf

    return ch;
}
/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
#define BUFFER_SIZE 40 //定义缓冲区大小
extern DMA_HandleTypeDef hdma_usart1_rx;
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
uint8_t receive_buff[BUFFER_SIZE];
int pointerX,pointerY,pointerCK;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */
  
  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_DMA_Init();
  MX_SPI1_Init();
  MX_TIM2_Init();
  MX_USART1_UART_Init();
  /* USER CODE BEGIN 2 */
  HAL_TIM_Base_Start_IT(&htim2);//使能定时器中断
  __HAL_UART_ENABLE_IT(&huart1,UART_IT_IDLE);//使能串口空闲IDLE中断
  HAL_UART_Receive_DMA(&huart1, (uint8_t*)receive_buff, BUFFER_SIZE); //设置DMA传输，将串口1的数据搬运到recvive_buff中，每次BUFFER_SIZE个字节
  
  /***************** LVGL Init ******************/
  lv_init();
  lv_port_disp_init(); //included "ST7735_Init();"
  lv_port_indev_init(); //init ext_input
  /***************** LVGL Init ******************/

  /*************** LVGL USER GUI ****************/
  lv_obj_t * label;
  lv_obj_t * btn1 = lv_btn_create(lv_scr_act(), NULL);
  lv_obj_align(btn1, NULL, LV_ALIGN_CENTER, 0, 0);
  label = lv_label_create(btn1, NULL);
  lv_label_set_text(label, "Button");
  lv_btn_set_checkable(btn1, false);
  lv_task_handler();
  /*************** LVGL USER GUI ****************/

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
    
    
    //HAL_Delay(1000);

  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL8;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */

void USAR_UART_IDLECallback(UART_HandleTypeDef *huart)
{
    // 停止本次DMA传输
    HAL_UART_DMAStop(&huart1);  
                                                       
    // 计算接收到的数据长度
    uint8_t data_length  = BUFFER_SIZE - __HAL_DMA_GET_COUNTER(&hdma_usart1_rx);   
    
    // 测试函数：将接收到的数据打印出去
    //printf("Receive Data(length = %d): ",data_length);
    //HAL_UART_Transmit(&huart1,receive_buff,data_length,0x200);                     
    //printf("\r\n");

    // DMA到鼠标变量
    uint8_t xc[4],yc[4];
    xc[0] = receive_buff[2];
    xc[1] = receive_buff[3];
    xc[2] = receive_buff[4];

    yc[0] = receive_buff[8];
    yc[1] = receive_buff[9];
    yc[2] = receive_buff[10]; 

    // 转换并存入全局变量，定值xxx为0开头自动去掉
    pointerX = atoi(xc);
    pointerY = atoi(yc);
    
    if(receive_buff[12] == '1') {pointerCK=1;} else {pointerCK=0;}
    //printf("X=%d,Y=%d,CK=%d\r\n",pointerX,pointerY,pointerCK);  //测试接口，已完成目标2021.8.14

    
    // 清零接收缓冲区
    memset(receive_buff,0,data_length);                                            
    data_length = 0;
    
    // 重启开始DMA传输 每次BUFFER_SIZE字节数据
    HAL_UART_Receive_DMA(&huart1, (uint8_t*)receive_buff, BUFFER_SIZE);                    
}

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */

  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{ 
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
