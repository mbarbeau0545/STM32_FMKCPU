/*********************************************************************
 * @file        FMKCPU_ConfigPublic.h
 * @brief       Template_BriefDescription.
 * @note        TemplateDetailsDescription.\n
 *
 * @author      mba
 * @date        31/08/2024
 * @version     1.0
 */
  
#ifndef FMKCPU_CONFIGPUBLIC_H_INCLUDED
#define FMKCPU_CONFIGPUBLIC_H_INCLUDED





    // ********************************************************************
    // *                      Includes
    // ********************************************************************
    /* CAUTION : Automatic generated code section for CPU Configuration: Start */
    #include "stm32g4xx_hal.h"
    #include "stm32g4xx.h"
    /* CAUTION : Automatic generated code section for CPU Configuration: End */
    #include "TypeCommon.h"
    #include "Constant.h"
    // ********************************************************************
    // *                      Defines
    // ********************************************************************
    // flag automatic generate code
    #define FMKCPU_STM32_ECU_FAMILY_G4 ((t_uint8)1)
    //#define FMKCPU_STM32_ECU_FAMILY_F ((t_uint8)0)
    
    #define FMKCPU_WWDG_RESET_CFG  FMKCPU_WWDG_RESET_100MS /**< default watchdogs configuration */

    #define FMKCPU_ADC_DMA_MODE             (DMA_CIRCULAR)      /**< DMA Mode for adc's */
    #define FMKCPU_UART_RX_DMA_MODE         (DMA_CIRCULAR)        /**< DMA Mode Uart for Rx */
    #define FMKCPU_UART_TX_DMA_MODE         (DMA_NORMAL)      /**< DMA Mode Uart for Tx */
    #define FMKCPU_USART_RX_DMA_MODE        (DMA_CIRCULAR)      /**< DMA Mode Uart for Rx */
    #define FMKCPU_USART_TX_DMA_MODE        (DMA_NORMAL)      /**< DMA Mode Uart for Tx */
    #define FMKCPU_TIM_CHNL_ECDR_CC1_MODE   (DMA_CIRCULAR)
    #define FMKCPU_TIM_CHNL_ECDR_CC2_MODE   (DMA_CIRCULAR)

    // ********************************************************************
    // *                      Types
    // ********************************************************************
    /**< Clock Core System Frequency Speed */
    typedef enum
    {
        FMKCPU_CORE_CLOCK_SPEED_8MHZ = 0x0U,    /**< Core CLock Speed Run at 8Mhz */
        FMKCPU_CORE_CLOCK_SPEED_16MHZ,          /**< Core CLock Speed Run at 16Mhz */
        FMKCPU_CORE_CLOCK_SPEED_32MHZ,          /**< Core CLock Speed Run at 32Mhz */
        FMKCPU_CORE_CLOCK_SPEED_40MHZ,          /**< Core CLock Speed Run at 40Mhz */
        FMKCPU_CORE_CLOCK_SPEED_48MHZ,          /**< Core CLock Speed Run at 48Mhz */
        FMKCPU_CORE_CLOCK_SPEED_64MHZ,          /**< Core CLock Speed Run at 64Mhz */
        FMKCPU_CORE_CLOCK_SPEED_80MHZ,          /**< Core CLock Speed Run at 80Mhz */
        FMKCPU_CORE_CLOCK_SPEED_96MHZ,          /**< Core CLock Speed Run at 96Mhz */
        FMKCPU_CORE_CLOCK_SPEED_128MHZ,         /**< Core CLock Speed Run at 132Mhz */
        FMKCPU_CORE_CLOCK_SPEED_160MHZ,         /**< Core CLock Speed Run at 160Mhz */

        FMKCPU_CORE_CLOCK_SPEED_NB,             /**< Core CLock Speed Run Number */
        FMKCPU_CORE_CLOCK_SPEED_UNKNOWN,             /**< Core CLock Speed Run Number */
    } t_eFMKCPU_CoreClockSpeed;

    /**< Enum for NVIC priority */
    typedef enum 
    {
        FMKCPU_NVIC_PRIORITY_LOW = 0x0U,    /**< Reference to bsp priority low value */
        FMKCPU_NVIC_PRIORITY_MEDIUM,        /**< Reference to bsp priority medium value */
        FMKCPU_NVIC_PRIORITY_HIGH,          /**< Reference to bsp priority high value */

        FMKCPU_NVIC_PRIORITY_NB             /**< Number of reference to bsp priority */
    } t_eFMKCPU_NVICPriority;

    
    /**< Enum for watchdog timer list */
    typedef enum
    {
        FMKCPU_WWDG_RESET_50MS = 0,     /**< Watchdogs reset parameter is 50 ms */
        FMKCPU_WWDG_RESET_100MS,        /**< Watchdogs reset parameter is 100 ms */
        FMKCPU_WWDG_RESET_200MS,        /**< Watchdogs reset parameter is 200 ms */
        FMKCPU_WWDG_RESET_500MS,        /**< Watchdogs reset parameter is 500 ms */

        FMKCPU_WWDG_RESET_NB,           /**< Number of watchdogs reset parameter  */
    } t_eFMKCPu_WwdgResetPeriod;


    typedef enum 
    {
        FMKCPU_DMA_TYPE_ADC = 0x00,
        FMKCPU_DMA_TYPE_UART_RX,
        FMKCPU_DMA_TYPE_UART_TX,
        FMKCPU_DMA_TYPE_USART_RX,
        FMKCPU_DMA_TYPE_USART_TX,
        FMKCPU_DMA_TYPE_SPI,
        FMKCMAC_DMA_TYPE_TIM_CHNL_ECDR_CC1,
        FMKCMAC_DMA_TYPE_TIM_CHNL_ECDR_CC2,

        FMKCPU_DMA_TYPE_NB,

    } t_eFMKCPU_DmaType;


    /**< Reference to Dma Priority */
    typedef enum
    {
        FMKCPU_DMA_TRANSPRIO_LOW = 0x0U,
        FMKCPU_DMA_TRANSPRIO_MEDIUM,
        FMKCPU_DMA_TRANSPRIO_HIGH,
        FMKCPU_DMA_TRANSPRIO_VERY_HIGH,

        FMKCPU_DMA_TRANSPRIO_NB,
    } t_eFMKCPU_DmaTransferPriority;

    /**< Reference for Dma Transfer Direction */
    typedef enum
    {
        FMKCPU_DMA_TRANSDIR_MEM_TO_MEM = 0x0U,
        FMKCPU_DMA_TRANSDIR_PERIPH_TO_MEM,
        FMKCPU_DMA_TRANSDIR_MEM_TO_PERIPH,

        FMKCPU_DMA_TRANSDIR_NB
    } t_eFMKCPU_DmaTransferDir;

    ///@brief diagnostic to determine the cause of a reset on cpu 
    typedef enum 
    {
        FMKCPU_RESET_CAUSE_NONE = 0,      /*!< No reset flags are active (or flags have been manually cleared) */

        FMKCPU_RESET_CAUSE_OBLRST,        /*!< Reset caused by Option Bytes reconfiguration (OBL reset).
                                            Typically triggered after updating flash option bytes via ST-Link
                                            or In-Application Programming (IAP). */

        FMKCPU_RESET_CAUSE_PINRST,        /*!< Reset triggered by the NRST pin (external hardware reset).
                                            This could be a reset button press or an external reset signal. */

        FMKCPU_RESET_CAUSE_BORRST,        /*!< Brown-Out Reset: caused when the supply voltage drops
                                            below a critical threshold, to prevent undefined behavior. */

        FMKCPU_RESET_CAUSE_SFRST,         /*!< Software Reset: triggered via software, for example by calling
                                            `NVIC_SystemReset()` or using internal system mechanisms. */

        FMKCPU_RESET_CAUSE_IWDRST,        /*!< Reset caused by the Independent Watchdog (IWDG),
                                            if the watchdog is not refreshed in time.
                                            Operates independently, even in Stop/Standby modes. */

        FMKCPU_RESET_CAUSE_WWDRST,        /*!< Reset caused by the Window Watchdog (WWDG),
                                            if the watchdog is refreshed too early, too late, or not at all.
                                            It is driven by the system clock. */

        FMKCPU_RESET_CAUSE_LPWRRST,       /*!< Reset due to a Low-Power event (Low-Power Reset),
                                            typically triggered during improper transitions
                                            into or out of Stop/Standby modes. */

    } t_eFMKCPU_CpuResetFlag;

    //-----------------------------ENUM TYPES-----------------------------//
    /* CAUTION : Automatic generated code section for Enum: Start */
    /**
    * @brief Enum for System Oscillator Clock.
    */
    typedef enum
    {
        FMKCPU_SYS_CLOCK_HSE = 0,                /**< Reference to Hardware Bus HSE */
        FMKCPU_SYS_CLOCK_HSI,                      /**< Reference to Hardware Bus HSI */
        FMKCPU_SYS_CLOCK_SYSTEM,                   /**< Reference to Hardware Bus SYSTEM */
        FMKCPU_SYS_CLOCK_HCLK1,                    /**< Reference to Hardware Bus HCLK1 */
        FMKCPU_SYS_CLOCK_AHB1,                     /**< Reference to Hardware Bus AHB1 */
        FMKCPU_SYS_CLOCK_AHB2,                     /**< Reference to Hardware Bus AHB2 */
        FMKCPU_SYS_CLOCK_APB1,                     /**< Reference to Hardware Bus APB1 */
        FMKCPU_SYS_CLOCK_APB2,                     /**< Reference to Hardware Bus APB2 */
        FMKCPU_SYS_CLOCK_PLLQ,                     /**< Reference to Hardware Bus PLLQ */
        FMKCPU_SYS_CLOCK_PLLP,                     /**< Reference to Hardware Bus PLLP */
    
        FMKCPU_SYS_CLOCK_NB,
    } t_eFMKCPU_SysClkOsc;

    /**
    * @brief Enum for rcc clock state reference.
    */
    typedef enum
    {
        FMKCPU_RCC_CLK_DMA1 = 0,               /**< Reference to RCC Clock DMA1 */
        FMKCPU_RCC_CLK_DMA2,                     /**< Reference to RCC Clock DMA2 */
        FMKCPU_RCC_CLK_DMAMUX1,                  /**< Reference to RCC Clock DMAMUX1 */
        FMKCPU_RCC_CLK_CORDIC,                   /**< Reference to RCC Clock CORDIC */
        FMKCPU_RCC_CLK_FMAC,                     /**< Reference to RCC Clock FMAC */
        FMKCPU_RCC_CLK_FLASH,                    /**< Reference to RCC Clock FLASH */
        FMKCPU_RCC_CLK_CRC,                      /**< Reference to RCC Clock CRC */
        FMKCPU_RCC_CLK_GPIOG,                    /**< Reference to RCC Clock GPIOG */
        FMKCPU_RCC_CLK_GPIOF,                    /**< Reference to RCC Clock GPIOF */
        FMKCPU_RCC_CLK_GPIOE,                    /**< Reference to RCC Clock GPIOE */
        FMKCPU_RCC_CLK_GPIOD,                    /**< Reference to RCC Clock GPIOD */
        FMKCPU_RCC_CLK_GPIOC,                    /**< Reference to RCC Clock GPIOC */
        FMKCPU_RCC_CLK_GPIOB,                    /**< Reference to RCC Clock GPIOB */
        FMKCPU_RCC_CLK_GPIOA,                    /**< Reference to RCC Clock GPIOA */
        FMKCPU_RCC_CLK_ADC12,                    /**< Reference to RCC Clock ADC12 */
        FMKCPU_RCC_CLK_ADC345,                   /**< Reference to RCC Clock ADC345 */
        FMKCPU_RCC_CLK_DAC1,                     /**< Reference to RCC Clock DAC1 */
        FMKCPU_RCC_CLK_DAC2,                     /**< Reference to RCC Clock DAC2 */
        FMKCPU_RCC_CLK_DAC3,                     /**< Reference to RCC Clock DAC3 */
        FMKCPU_RCC_CLK_DAC4,                     /**< Reference to RCC Clock DAC4 */
        FMKCPU_RCC_CLK_RNG,                      /**< Reference to RCC Clock RNG */
        FMKCPU_RCC_CLK_FMC,                      /**< Reference to RCC Clock FMC */
        FMKCPU_RCC_CLK_QSPI,                     /**< Reference to RCC Clock QSPI */
        FMKCPU_RCC_CLK_TIM2,                     /**< Reference to RCC Clock TIM2 */
        FMKCPU_RCC_CLK_TIM3,                     /**< Reference to RCC Clock TIM3 */
        FMKCPU_RCC_CLK_TIM4,                     /**< Reference to RCC Clock TIM4 */
        FMKCPU_RCC_CLK_TIM5,                     /**< Reference to RCC Clock TIM5 */
        FMKCPU_RCC_CLK_TIM6,                     /**< Reference to RCC Clock TIM6 */
        FMKCPU_RCC_CLK_TIM7,                     /**< Reference to RCC Clock TIM7 */
        FMKCPU_RCC_CLK_CRS,                      /**< Reference to RCC Clock CRS */
        FMKCPU_RCC_CLK_RTCAPB,                   /**< Reference to RCC Clock RTCAPB */
        FMKCPU_RCC_CLK_WWDG,                     /**< Reference to RCC Clock WWDG */
        FMKCPU_RCC_CLK_SPI2,                     /**< Reference to RCC Clock SPI2 */
        FMKCPU_RCC_CLK_SPI3,                     /**< Reference to RCC Clock SPI3 */
        FMKCPU_RCC_CLK_USART2,                   /**< Reference to RCC Clock USART2 */
        FMKCPU_RCC_CLK_USART3,                   /**< Reference to RCC Clock USART3 */
        FMKCPU_RCC_CLK_UART4,                    /**< Reference to RCC Clock UART4 */
        FMKCPU_RCC_CLK_UART5,                    /**< Reference to RCC Clock UART5 */
        FMKCPU_RCC_CLK_I2C2,                     /**< Reference to RCC Clock I2C2 */
        FMKCPU_RCC_CLK_USB,                      /**< Reference to RCC Clock USB */
        FMKCPU_RCC_CLK_FDCAN,                    /**< Reference to RCC Clock FDCAN */
        FMKCPU_RCC_CLK_PWR,                      /**< Reference to RCC Clock PWR */
        FMKCPU_RCC_CLK_I2C3,                     /**< Reference to RCC Clock I2C3 */
        FMKCPU_RCC_CLK_LPTIM1,                   /**< Reference to RCC Clock LPTIM1 */
        FMKCPU_RCC_CLK_UCPD1,                    /**< Reference to RCC Clock UCPD1 */
        FMKCPU_RCC_CLK_SYSCFG,                   /**< Reference to RCC Clock SYSCFG */
        FMKCPU_RCC_CLK_TIM1,                     /**< Reference to RCC Clock TIM1 */
        FMKCPU_RCC_CLK_SPI1,                     /**< Reference to RCC Clock SPI1 */
        FMKCPU_RCC_CLK_TIM8,                     /**< Reference to RCC Clock TIM8 */
        FMKCPU_RCC_CLK_USART1,                   /**< Reference to RCC Clock USART1 */
        FMKCPU_RCC_CLK_SPI4,                     /**< Reference to RCC Clock SPI4 */
        FMKCPU_RCC_CLK_TIM15,                    /**< Reference to RCC Clock TIM15 */
        FMKCPU_RCC_CLK_TIM16,                    /**< Reference to RCC Clock TIM16 */
        FMKCPU_RCC_CLK_TIM17,                    /**< Reference to RCC Clock TIM17 */
        FMKCPU_RCC_CLK_TIM20,                    /**< Reference to RCC Clock TIM20 */
        FMKCPU_RCC_CLK_SAI1,                     /**< Reference to RCC Clock SAI1 */
        FMKCPU_RCC_CLK_HRTIM1,                   /**< Reference to RCC Clock HRTIM1 */
    
        FMKCPU_RCC_CLK_NB,
    } t_eFMKCPU_ClockPort;

    /**
    * @brief Enum for NVIC list.
    */
    typedef enum
    {
        FMKCPU_NVIC_WWDG_IRQN = 0,          /**< Reference to HAL nvic WWDG_IRQn */
        FMKCPU_NVIC_PVD_PVM_IRQN,             /**< Reference to HAL nvic PVD_PVM_IRQn */
        FMKCPU_NVIC_RTC_TAMP_LSECSS_IRQN,     /**< Reference to HAL nvic RTC_TAMP_LSECSS_IRQn */
        FMKCPU_NVIC_RTC_WKUP_IRQN,            /**< Reference to HAL nvic RTC_WKUP_IRQn */
        FMKCPU_NVIC_FLASH_IRQN,               /**< Reference to HAL nvic FLASH_IRQn */
        FMKCPU_NVIC_RCC_IRQN,                 /**< Reference to HAL nvic RCC_IRQn */
        FMKCPU_NVIC_EXTI0_IRQN,               /**< Reference to HAL nvic EXTI0_IRQn */
        FMKCPU_NVIC_EXTI1_IRQN,               /**< Reference to HAL nvic EXTI1_IRQn */
        FMKCPU_NVIC_EXTI2_IRQN,               /**< Reference to HAL nvic EXTI2_IRQn */
        FMKCPU_NVIC_EXTI3_IRQN,               /**< Reference to HAL nvic EXTI3_IRQn */
        FMKCPU_NVIC_EXTI4_IRQN,               /**< Reference to HAL nvic EXTI4_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL1_IRQN,       /**< Reference to HAL nvic DMA1_Channel1_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL2_IRQN,       /**< Reference to HAL nvic DMA1_Channel2_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL3_IRQN,       /**< Reference to HAL nvic DMA1_Channel3_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL4_IRQN,       /**< Reference to HAL nvic DMA1_Channel4_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL5_IRQN,       /**< Reference to HAL nvic DMA1_Channel5_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL6_IRQN,       /**< Reference to HAL nvic DMA1_Channel6_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL7_IRQN,       /**< Reference to HAL nvic DMA1_Channel7_IRQn */
        FMKCPU_NVIC_ADC1_2_IRQN,              /**< Reference to HAL nvic ADC1_2_IRQn */
        FMKCPU_NVIC_USB_HP_IRQN,              /**< Reference to HAL nvic USB_HP_IRQn */
        FMKCPU_NVIC_USB_LP_IRQN,              /**< Reference to HAL nvic USB_LP_IRQn */
        FMKCPU_NVIC_FDCAN1_IT0_IRQN,          /**< Reference to HAL nvic FDCAN1_IT0_IRQn */
        FMKCPU_NVIC_FDCAN1_IT1_IRQN,          /**< Reference to HAL nvic FDCAN1_IT1_IRQn */
        FMKCPU_NVIC_EXTI9_5_IRQN,             /**< Reference to HAL nvic EXTI9_5_IRQn */
        FMKCPU_NVIC_TIM1_BRK_TIM15_IRQN,      /**< Reference to HAL nvic TIM1_BRK_TIM15_IRQn */
        FMKCPU_NVIC_TIM1_UP_TIM16_IRQN,       /**< Reference to HAL nvic TIM1_UP_TIM16_IRQn */
        FMKCPU_NVIC_TIM1_TRG_COM_TIM17_IRQN,  /**< Reference to HAL nvic TIM1_TRG_COM_TIM17_IRQn */
        FMKCPU_NVIC_TIM1_CC_IRQN,             /**< Reference to HAL nvic TIM1_CC_IRQn */
        FMKCPU_NVIC_TIM2_IRQN,                /**< Reference to HAL nvic TIM2_IRQn */
        FMKCPU_NVIC_TIM3_IRQN,                /**< Reference to HAL nvic TIM3_IRQn */
        FMKCPU_NVIC_TIM4_IRQN,                /**< Reference to HAL nvic TIM4_IRQn */
        FMKCPU_NVIC_I2C1_EV_IRQN,             /**< Reference to HAL nvic I2C1_EV_IRQn */
        FMKCPU_NVIC_I2C1_ER_IRQN,             /**< Reference to HAL nvic I2C1_ER_IRQn */
        FMKCPU_NVIC_I2C2_EV_IRQN,             /**< Reference to HAL nvic I2C2_EV_IRQn */
        FMKCPU_NVIC_I2C2_ER_IRQN,             /**< Reference to HAL nvic I2C2_ER_IRQn */
        FMKCPU_NVIC_SPI1_IRQN,                /**< Reference to HAL nvic SPI1_IRQn */
        FMKCPU_NVIC_SPI2_IRQN,                /**< Reference to HAL nvic SPI2_IRQn */
        FMKCPU_NVIC_USART1_IRQN,              /**< Reference to HAL nvic USART1_IRQn */
        FMKCPU_NVIC_USART2_IRQN,              /**< Reference to HAL nvic USART2_IRQn */
        FMKCPU_NVIC_USART3_IRQN,              /**< Reference to HAL nvic USART3_IRQn */
        FMKCPU_NVIC_EXTI15_10_IRQN,           /**< Reference to HAL nvic EXTI15_10_IRQn */
        FMKCPU_NVIC_RTC_ALARM_IRQN,           /**< Reference to HAL nvic RTC_Alarm_IRQn */
        FMKCPU_NVIC_USBWAKEUP_IRQN,           /**< Reference to HAL nvic USBWakeUp_IRQn */
        FMKCPU_NVIC_TIM8_BRK_IRQN,            /**< Reference to HAL nvic TIM8_BRK_IRQn */
        FMKCPU_NVIC_TIM8_UP_IRQN,             /**< Reference to HAL nvic TIM8_UP_IRQn */
        FMKCPU_NVIC_TIM8_TRG_COM_IRQN,        /**< Reference to HAL nvic TIM8_TRG_COM_IRQn */
        FMKCPU_NVIC_TIM8_CC_IRQN,             /**< Reference to HAL nvic TIM8_CC_IRQn */
        FMKCPU_NVIC_ADC3_IRQN,                /**< Reference to HAL nvic ADC3_IRQn */
        FMKCPU_NVIC_FMC_IRQN,                 /**< Reference to HAL nvic FMC_IRQn */
        FMKCPU_NVIC_LPTIM1_IRQN,              /**< Reference to HAL nvic LPTIM1_IRQn */
        FMKCPU_NVIC_TIM5_IRQN,                /**< Reference to HAL nvic TIM5_IRQn */
        FMKCPU_NVIC_SPI3_IRQN,                /**< Reference to HAL nvic SPI3_IRQn */
        FMKCPU_NVIC_UART4_IRQN,               /**< Reference to HAL nvic UART4_IRQn */
        FMKCPU_NVIC_UART5_IRQN,               /**< Reference to HAL nvic UART5_IRQn */
        FMKCPU_NVIC_TIM6_DAC_IRQN,            /**< Reference to HAL nvic TIM6_DAC_IRQn */
        FMKCPU_NVIC_TIM7_DAC_IRQN,            /**< Reference to HAL nvic TIM7_DAC_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL1_IRQN,       /**< Reference to HAL nvic DMA2_Channel1_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL2_IRQN,       /**< Reference to HAL nvic DMA2_Channel2_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL3_IRQN,       /**< Reference to HAL nvic DMA2_Channel3_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL4_IRQN,       /**< Reference to HAL nvic DMA2_Channel4_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL5_IRQN,       /**< Reference to HAL nvic DMA2_Channel5_IRQn */
        FMKCPU_NVIC_ADC4_IRQN,                /**< Reference to HAL nvic ADC4_IRQn */
        FMKCPU_NVIC_ADC5_IRQN,                /**< Reference to HAL nvic ADC5_IRQn */
        FMKCPU_NVIC_UCPD1_IRQN,               /**< Reference to HAL nvic UCPD1_IRQn */
        FMKCPU_NVIC_COMP1_2_3_IRQN,           /**< Reference to HAL nvic COMP1_2_3_IRQn */
        FMKCPU_NVIC_COMP4_5_6_IRQN,           /**< Reference to HAL nvic COMP4_5_6_IRQn */
        FMKCPU_NVIC_COMP7_IRQN,               /**< Reference to HAL nvic COMP7_IRQn */
        FMKCPU_NVIC_HRTIM1_MASTER_IRQN,       /**< Reference to HAL nvic HRTIM1_Master_IRQn */
        FMKCPU_NVIC_HRTIM1_TIMA_IRQN,         /**< Reference to HAL nvic HRTIM1_TIMA_IRQn */
        FMKCPU_NVIC_HRTIM1_TIMB_IRQN,         /**< Reference to HAL nvic HRTIM1_TIMB_IRQn */
        FMKCPU_NVIC_HRTIM1_TIMC_IRQN,         /**< Reference to HAL nvic HRTIM1_TIMC_IRQn */
        FMKCPU_NVIC_HRTIM1_TIMD_IRQN,         /**< Reference to HAL nvic HRTIM1_TIMD_IRQn */
        FMKCPU_NVIC_HRTIM1_TIME_IRQN,         /**< Reference to HAL nvic HRTIM1_TIME_IRQn */
        FMKCPU_NVIC_HRTIM1_FLT_IRQN,          /**< Reference to HAL nvic HRTIM1_FLT_IRQn */
        FMKCPU_NVIC_HRTIM1_TIMF_IRQN,         /**< Reference to HAL nvic HRTIM1_TIMF_IRQn */
        FMKCPU_NVIC_CRS_IRQN,                 /**< Reference to HAL nvic CRS_IRQn */
        FMKCPU_NVIC_SAI1_IRQN,                /**< Reference to HAL nvic SAI1_IRQn */
        FMKCPU_NVIC_TIM20_BRK_IRQN,           /**< Reference to HAL nvic TIM20_BRK_IRQn */
        FMKCPU_NVIC_TIM20_UP_IRQN,            /**< Reference to HAL nvic TIM20_UP_IRQn */
        FMKCPU_NVIC_TIM20_TRG_COM_IRQN,       /**< Reference to HAL nvic TIM20_TRG_COM_IRQn */
        FMKCPU_NVIC_TIM20_CC_IRQN,            /**< Reference to HAL nvic TIM20_CC_IRQn */
        FMKCPU_NVIC_FPU_IRQN,                 /**< Reference to HAL nvic FPU_IRQn */
        FMKCPU_NVIC_I2C4_EV_IRQN,             /**< Reference to HAL nvic I2C4_EV_IRQn */
        FMKCPU_NVIC_I2C4_ER_IRQN,             /**< Reference to HAL nvic I2C4_ER_IRQn */
        FMKCPU_NVIC_SPI4_IRQN,                /**< Reference to HAL nvic SPI4_IRQn */
        FMKCPU_NVIC_FDCAN2_IT0_IRQN,          /**< Reference to HAL nvic FDCAN2_IT0_IRQn */
        FMKCPU_NVIC_FDCAN2_IT1_IRQN,          /**< Reference to HAL nvic FDCAN2_IT1_IRQn */
        FMKCPU_NVIC_FDCAN3_IT0_IRQN,          /**< Reference to HAL nvic FDCAN3_IT0_IRQn */
        FMKCPU_NVIC_FDCAN3_IT1_IRQN,          /**< Reference to HAL nvic FDCAN3_IT1_IRQn */
        FMKCPU_NVIC_RNG_IRQN,                 /**< Reference to HAL nvic RNG_IRQn */
        FMKCPU_NVIC_LPUART1_IRQN,             /**< Reference to HAL nvic LPUART1_IRQn */
        FMKCPU_NVIC_I2C3_EV_IRQN,             /**< Reference to HAL nvic I2C3_EV_IRQn */
        FMKCPU_NVIC_I2C3_ER_IRQN,             /**< Reference to HAL nvic I2C3_ER_IRQn */
        FMKCPU_NVIC_DMAMUX_OVR_IRQN,          /**< Reference to HAL nvic DMAMUX_OVR_IRQn */
        FMKCPU_NVIC_QUADSPI_IRQN,             /**< Reference to HAL nvic QUADSPI_IRQn */
        FMKCPU_NVIC_DMA1_CHANNEL8_IRQN,       /**< Reference to HAL nvic DMA1_Channel8_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL6_IRQN,       /**< Reference to HAL nvic DMA2_Channel6_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL7_IRQN,       /**< Reference to HAL nvic DMA2_Channel7_IRQn */
        FMKCPU_NVIC_DMA2_CHANNEL8_IRQN,       /**< Reference to HAL nvic DMA2_Channel8_IRQn */
        FMKCPU_NVIC_CORDIC_IRQN,              /**< Reference to HAL nvic CORDIC_IRQn */
        FMKCPU_NVIC_FMAC_IRQN,                /**< Reference to HAL nvic FMAC_IRQn */
    
        FMKCPU_NVIC_NB,
    } t_eFMKCPU_IRQNType;

    /**
    * @brief Enum for the different request available for DMA service.
    */
    typedef enum
    {
        FMKCPU_DMA_RQSTYPE_ADC1 = 0,               /**< Reference to Bsp Dma Request for ADC1 */
        FMKCPU_DMA_RQSTYPE_ADC2,                     /**< Reference to Bsp Dma Request for ADC2 */
        FMKCPU_DMA_RQSTYPE_ADC3,                     /**< Reference to Bsp Dma Request for ADC3 */
        FMKCPU_DMA_RQSTYPE_ADC4,                     /**< Reference to Bsp Dma Request for ADC4 */
        FMKCPU_DMA_RQSTYPE_ADC5,                     /**< Reference to Bsp Dma Request for ADC5 */
        FMKCPU_DMA_RQSTYPE_UART4_RX,                 /**< Reference to Bsp Dma Request for UART4_RX */
        FMKCPU_DMA_RQSTYPE_UART4_TX,                 /**< Reference to Bsp Dma Request for UART4_TX */
        FMKCPU_DMA_RQSTYPE_USART1_RX,                /**< Reference to Bsp Dma Request for USART1_RX */
        FMKCPU_DMA_RQSTYPE_USART1_TX,                /**< Reference to Bsp Dma Request for USART1_TX */
        FMKCPU_DMA_RQSTYPE_USART2_RX,                /**< Reference to Bsp Dma Request for USART2_RX */
        FMKCPU_DMA_RQSTYPE_USART2_TX,                /**< Reference to Bsp Dma Request for USART2_TX */
        FMKCPU_DMA_RQSTYPE_USART3_RX,                /**< Reference to Bsp Dma Request for USART3_RX */
        FMKCPU_DMA_RQSTYPE_USART3_TX,                /**< Reference to Bsp Dma Request for USART3_TX */
        FMKCPU_DMA_RQSTYPE_TIM8_CH1,                 /**< Reference to Bsp Dma Request for TIM8_CH1 */
    
        FMKCPU_DMA_RQSTYPE_NB,
    } t_eFMKCPU_DmaRqst;

    /**
    * @brief Enum for Number of Dma.
    */
    typedef enum
    {
        FMKCPU_DMA_CTRL_1 = 0,                  /**< Reference to DMA 1 */
        FMKCPU_DMA_CTRL_2,                        /**< Reference to DMA 2 */
    
        FMKCPU_DMA_CTRL_NB,
    } t_eFMKCPU_DmaController;

    /**
    * @brief Enum for number of channel in DMA.
    */
    typedef enum
    {
        FMKCPU_DMA_CHANNEL_1 = 0,                  /**< Reference to Channel 1 */
        FMKCPU_DMA_CHANNEL_2,                        /**< Reference to Channel 2 */
        FMKCPU_DMA_CHANNEL_3,                        /**< Reference to Channel 3 */
        FMKCPU_DMA_CHANNEL_4,                        /**< Reference to Channel 4 */
        FMKCPU_DMA_CHANNEL_5,                        /**< Reference to Channel 5 */
        FMKCPU_DMA_CHANNEL_6,                        /**< Reference to Channel 6 */
        FMKCPU_DMA_CHANNEL_7,                        /**< Reference to Channel 7 */
        FMKCPU_DMA_CHANNEL_8,                        /**< Reference to Channel 8 */
    
        FMKCPU_DMA_CHANNEL_NB,
    } t_eFMKCPU_DmaChnl;

    /**
    * @brief Enum for Number of Dma Multiplexage Controler.
    */
    typedef enum
    {
        FMKCPU_DMA_MUX_1 = 0,                  /**< Reference to DMAMUX 1 */
    
        FMKCPU_DMA_MUX_NB,
    } t_eFMKCPU_DmaMux;

    /* CAUTION : Automatic generated code section for Enum: End */
  
    
    //-----------------------------TYPEDEF TYPES---------------------------//
    /**< Union to centralize Dma Handle TypeDef  */
    typedef union 
    {
        ADC_HandleTypeDef   adcHandle_s;
        USART_HandleTypeDef usartHandle_s;
        UART_HandleTypeDef  uartHandle_s;
        SPI_HandleTypeDef   spiHandle_s;
        TIM_HandleTypeDef   timHandle_s;
    } t_uFMKCPU_DmaHandleType;

    //-----------------------------STRUCT TYPES---------------------------//
    // ********************************************************************
    // *                      Prototypes
    // ********************************************************************
        
    // ********************************************************************
    // *                      Variables
    // ********************************************************************

    //********************************************************************************
    //                      Public functions - Prototyupes
    //********************************************************************************

#endif // FMKCPU_CONFIGPUBLIC_H_INCLUDED           
//************************************************************************************
// End of File
//************************************************************************************         


/**
 *
 *	@brief
 *	@note   
 *
 *
 *	@param[in] 
 *	@param[out]
 *	 
 *
 *
 */
