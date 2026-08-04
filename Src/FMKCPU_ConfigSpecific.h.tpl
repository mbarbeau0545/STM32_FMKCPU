/*********************************************************************
 * @file        FMKCPU_ConfigSpecific.h
 * @brief       Template_BriefDescription.
 * @note        TemplateDetailsDescription.\n
 *
 * @author      xxxxxx
 * @date        jj/mm/yyyy
 * @version     1.0
 */
  
#ifndef FMKCPU_CONFIGSPECIFIC_H_INCLUDED
#define FMKCPU_CONFIGSPECIFIC_H_INCLUDED





    // ********************************************************************
    // *                      Includes
    // ********************************************************************
    #include "FMK_CFG/FMKCFG_ConfigFiles/FMKCPU_ConfigPublic.h"
    #include "FMK_HAL/FMK_CPU/Src/FMK_CPU.h"
    #include "TypeCommon.h"
    // ********************************************************************
    // *                      Defines
    // ********************************************************************

    // ********************************************************************
    // *                      Types
    // ********************************************************************
    //-----------------------------ENUM TYPES-----------------------------//
    /* CAUTION : Automatic generated code section for Enum: Start */

    /* CAUTION : Automatic generated code section for Enum: End */

    //-----------------------------TYPEDEF TYPES---------------------------//
    //-----------------------------STRUCT TYPES---------------------------//
    /* CAUTION : Automatic generated code section for Structure: Start */

    /* CAUTION : Automatic generated code section for Structure: End */
    // ********************************************************************
    // *                      Prototypes
    // ********************************************************************
        
    // ********************************************************************
    // *                      Variables
    // ********************************************************************

    //********************************************************************************
    //                      Public functions - Prototyupes
    //********************************************************************************
    /**
    *
    *	@brief      Fill the system clock HAL structures with ECU-family specific fields.
    *
    *	@param[in]  f_RccOscCfg_ps        : HAL oscillator config structure to fill.
    *	@param[in]  f_RccClkCfg_ps        : HAL clock config structure to fill.
    *	@param[in]  f_sysOscCfg_ps        : generated system clock divider configuration.
    *	@param[in]  f_pll1OscCfg_ps       : generated PLL1 configuration.
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
    *
    */
    t_eReturnCode FMKCPU_Set_BspSystemClockCfg( RCC_OscInitTypeDef *f_RccOscCfg_ps,
                                                RCC_ClkInitTypeDef *f_RccClkCfg_ps,
                                                const t_sFMKCPU_SysOscCfg *f_sysOscCfg_ps,
                                                const t_sFMKCPU_PllOscCfg *f_pll1OscCfg_ps);
    /**
    *
    *	@brief      Perform ECU-family specific hardware init before HAL_Init.
    *
    *  @retval RC_OK                             @ref RC_OK
    *
    */
    t_eReturnCode FMKCPU_Set_BspHardwareInitBeforeHal(void);
    /**
    *
    *	@brief      Perform ECU-family specific hardware init after HAL_Init.
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_WRONG_RESULT             @ref RC_ERROR_WRONG_RESULT
    *
    */
    t_eReturnCode FMKCPU_Set_BspHardwareInitAfterHal(void);
    /**
    *
    *	@brief      Decode ECU-family specific reset flags.
    *
    *	@param[out] f_resetFlag_pe        : reset flag storage.
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
    *
    */
    t_eReturnCode FMKCPU_CheckResetCpuFlagSpecific(t_eFMKCPU_CpuResetFlag *f_resetFlag_pe);
    /**
    *
    *	@brief      Function to get the bsp IRQN enum
    *
    *	@param[in]  f_IRQN_e              : enum value for the priority, value from @ref t_eFMKCPU_IRQNType
    *	@param[in]  f_bspIRQN_pe          : storage for NVIC priority.\n
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
    *  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
    *  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
    *
    */
    t_eReturnCode FMKCPU_Get_BspIRQNType(t_eFMKCPU_IRQNType f_IRQN_e, IRQn_Type *f_bspIRQN_pe);

    /**
    *
    *	@brief    Set the Periph Clock Configuration
    *
    *	@param[in]  f_clockPort_e             : Rcc Clock Port, enum value from @ref t_eFMKCPU_ClockPort

    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
    *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
    *  @retval RC_ERROR_ALREADY_CONFIGURED       @ref RC_ERROR_ALREADY_CONFIGURED
    *  @retval RC_ERROR_NOT_ALLOWED              @ref RC_ERROR_NOT_ALLOWED
    */                                           
    t_eReturnCode FMKCPU_SetPeriphClockCfg(t_sFMKCPU_PllOscCfg ** f_PllOtherCfg_pas);
    /**
    *
    *	@brief    Set the Periph Clock Configuration
    *
    *	@param[in]  f_clockPort_e             : Rcc Clock Port, enum value from @ref t_eFMKCPU_ClockPort

    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
    *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
    *  @retval RC_ERROR_ALREADY_CONFIGURED       @ref RC_ERROR_ALREADY_CONFIGURED
    *  @retval RC_ERROR_NOT_ALLOWED              @ref RC_ERROR_NOT_ALLOWED
    */
    t_eReturnCode FMKCPU_SetRequestType(t_eFMKCPU_DmaRqst f_RqstType_e,
                                        DMA_HandleTypeDef * f_bspDma_ps);
    
    /* CAUTION : Automatic generated code section for Enable Clk Declaration: Start */
    /**< Function to enable  ADC12 rcc clock*/
    void FMKCPU_Enable_ADC12_Clock(void);
    /**< Function to enable  ADC3 rcc clock*/
    void FMKCPU_Enable_ADC3_Clock(void);
    /**< Function to enable  BDMA rcc clock*/
    void FMKCPU_Enable_BDMA_Clock(void);
    /**< Function to enable  BKPRAM rcc clock*/
    void FMKCPU_Enable_BKPRAM_Clock(void);
    /**< Function to enable  CEC rcc clock*/
    void FMKCPU_Enable_CEC_Clock(void);
    /**< Function to enable  COMP12 rcc clock*/
    void FMKCPU_Enable_COMP12_Clock(void);
    /**< Function to enable  CRC rcc clock*/
    void FMKCPU_Enable_CRC_Clock(void);
    /**< Function to enable  CRS rcc clock*/
    void FMKCPU_Enable_CRS_Clock(void);
    /**< Function to enable  CRYP rcc clock*/
    void FMKCPU_Enable_CRYP_Clock(void);
    /**< Function to enable  D2SRAM1 rcc clock*/
    void FMKCPU_Enable_D2SRAM1_Clock(void);
    /**< Function to enable  D2SRAM2 rcc clock*/
    void FMKCPU_Enable_D2SRAM2_Clock(void);
    /**< Function to enable  D2SRAM3 rcc clock*/
    void FMKCPU_Enable_D2SRAM3_Clock(void);
    /**< Function to enable  DAC12 rcc clock*/
    void FMKCPU_Enable_DAC12_Clock(void);
    /**< Function to enable  DCMI rcc clock*/
    void FMKCPU_Enable_DCMI_Clock(void);
    /**< Function to enable  DFSDM1 rcc clock*/
    void FMKCPU_Enable_DFSDM1_Clock(void);
    /**< Function to enable  DMA1 rcc clock*/
    void FMKCPU_Enable_DMA1_Clock(void);
    /**< Function to enable  DMA2 rcc clock*/
    void FMKCPU_Enable_DMA2_Clock(void);
    /**< Function to enable  DMA2D rcc clock*/
    void FMKCPU_Enable_DMA2D_Clock(void);
    /**< Function to enable  ETH1MAC rcc clock*/
    void FMKCPU_Enable_ETH1MAC_Clock(void);
    /**< Function to enable  ETH1RX rcc clock*/
    void FMKCPU_Enable_ETH1RX_Clock(void);
    /**< Function to enable  ETH1TX rcc clock*/
    void FMKCPU_Enable_ETH1TX_Clock(void);
    /**< Function to enable  FDCAN rcc clock*/
    void FMKCPU_Enable_FDCAN_Clock(void);
    /**< Function to enable  FMC rcc clock*/
    void FMKCPU_Enable_FMC_Clock(void);
    /**< Function to enable  GPIOA rcc clock*/
    void FMKCPU_Enable_GPIOA_Clock(void);
    /**< Function to enable  GPIOB rcc clock*/
    void FMKCPU_Enable_GPIOB_Clock(void);
    /**< Function to enable  GPIOC rcc clock*/
    void FMKCPU_Enable_GPIOC_Clock(void);
    /**< Function to enable  GPIOD rcc clock*/
    void FMKCPU_Enable_GPIOD_Clock(void);
    /**< Function to enable  GPIOE rcc clock*/
    void FMKCPU_Enable_GPIOE_Clock(void);
    /**< Function to enable  GPIOF rcc clock*/
    void FMKCPU_Enable_GPIOF_Clock(void);
    /**< Function to enable  GPIOG rcc clock*/
    void FMKCPU_Enable_GPIOG_Clock(void);
    /**< Function to enable  GPIOH rcc clock*/
    void FMKCPU_Enable_GPIOH_Clock(void);
    /**< Function to enable  GPIOI rcc clock*/
    void FMKCPU_Enable_GPIOI_Clock(void);
    /**< Function to enable  GPIOJ rcc clock*/
    void FMKCPU_Enable_GPIOJ_Clock(void);
    /**< Function to enable  GPIOK rcc clock*/
    void FMKCPU_Enable_GPIOK_Clock(void);
    /**< Function to enable  HASH rcc clock*/
    void FMKCPU_Enable_HASH_Clock(void);
    /**< Function to enable  HRTIM1 rcc clock*/
    void FMKCPU_Enable_HRTIM1_Clock(void);
    /**< Function to enable  HSEM rcc clock*/
    void FMKCPU_Enable_HSEM_Clock(void);
    /**< Function to enable  I2C1 rcc clock*/
    void FMKCPU_Enable_I2C1_Clock(void);
    /**< Function to enable  I2C2 rcc clock*/
    void FMKCPU_Enable_I2C2_Clock(void);
    /**< Function to enable  I2C3 rcc clock*/
    void FMKCPU_Enable_I2C3_Clock(void);
    /**< Function to enable  I2C4 rcc clock*/
    void FMKCPU_Enable_I2C4_Clock(void);
    /**< Function to enable  JPGDECEN rcc clock*/
    void FMKCPU_Enable_JPGDECEN_Clock(void);
    /**< Function to enable  LPTIM1 rcc clock*/
    void FMKCPU_Enable_LPTIM1_Clock(void);
    /**< Function to enable  LPTIM2 rcc clock*/
    void FMKCPU_Enable_LPTIM2_Clock(void);
    /**< Function to enable  LPTIM3 rcc clock*/
    void FMKCPU_Enable_LPTIM3_Clock(void);
    /**< Function to enable  LPTIM4 rcc clock*/
    void FMKCPU_Enable_LPTIM4_Clock(void);
    /**< Function to enable  LPTIM5 rcc clock*/
    void FMKCPU_Enable_LPTIM5_Clock(void);
    /**< Function to enable  LPUART1 rcc clock*/
    void FMKCPU_Enable_LPUART1_Clock(void);
    /**< Function to enable  LTDC rcc clock*/
    void FMKCPU_Enable_LTDC_Clock(void);
    /**< Function to enable  MDIOS rcc clock*/
    void FMKCPU_Enable_MDIOS_Clock(void);
    /**< Function to enable  MDMA rcc clock*/
    void FMKCPU_Enable_MDMA_Clock(void);
    /**< Function to enable  OPAMP rcc clock*/
    void FMKCPU_Enable_OPAMP_Clock(void);
    /**< Function to enable  QSPI rcc clock*/
    void FMKCPU_Enable_QSPI_Clock(void);
    /**< Function to enable  RNG rcc clock*/
    void FMKCPU_Enable_RNG_Clock(void);
    /**< Function to enable  RTC rcc clock*/
    void FMKCPU_Enable_RTC_Clock(void);
    /**< Function to enable  SAI1 rcc clock*/
    void FMKCPU_Enable_SAI1_Clock(void);
    /**< Function to enable  SAI2 rcc clock*/
    void FMKCPU_Enable_SAI2_Clock(void);
    /**< Function to enable  SAI3 rcc clock*/
    void FMKCPU_Enable_SAI3_Clock(void);
    /**< Function to enable  SAI4 rcc clock*/
    void FMKCPU_Enable_SAI4_Clock(void);
    /**< Function to enable  SDMMC1 rcc clock*/
    void FMKCPU_Enable_SDMMC1_Clock(void);
    /**< Function to enable  SDMMC2 rcc clock*/
    void FMKCPU_Enable_SDMMC2_Clock(void);
    /**< Function to enable  SPDIFRX rcc clock*/
    void FMKCPU_Enable_SPDIFRX_Clock(void);
    /**< Function to enable  SPI1 rcc clock*/
    void FMKCPU_Enable_SPI1_Clock(void);
    /**< Function to enable  SPI2 rcc clock*/
    void FMKCPU_Enable_SPI2_Clock(void);
    /**< Function to enable  SPI3 rcc clock*/
    void FMKCPU_Enable_SPI3_Clock(void);
    /**< Function to enable  SPI4 rcc clock*/
    void FMKCPU_Enable_SPI4_Clock(void);
    /**< Function to enable  SPI5 rcc clock*/
    void FMKCPU_Enable_SPI5_Clock(void);
    /**< Function to enable  SPI6 rcc clock*/
    void FMKCPU_Enable_SPI6_Clock(void);
    /**< Function to enable  SWPMI1 rcc clock*/
    void FMKCPU_Enable_SWPMI1_Clock(void);
    /**< Function to enable  SYSCFG rcc clock*/
    void FMKCPU_Enable_SYSCFG_Clock(void);
    /**< Function to enable  TIM1 rcc clock*/
    void FMKCPU_Enable_TIM1_Clock(void);
    /**< Function to enable  TIM12 rcc clock*/
    void FMKCPU_Enable_TIM12_Clock(void);
    /**< Function to enable  TIM13 rcc clock*/
    void FMKCPU_Enable_TIM13_Clock(void);
    /**< Function to enable  TIM14 rcc clock*/
    void FMKCPU_Enable_TIM14_Clock(void);
    /**< Function to enable  TIM15 rcc clock*/
    void FMKCPU_Enable_TIM15_Clock(void);
    /**< Function to enable  TIM16 rcc clock*/
    void FMKCPU_Enable_TIM16_Clock(void);
    /**< Function to enable  TIM17 rcc clock*/
    void FMKCPU_Enable_TIM17_Clock(void);
    /**< Function to enable  TIM2 rcc clock*/
    void FMKCPU_Enable_TIM2_Clock(void);
    /**< Function to enable  TIM3 rcc clock*/
    void FMKCPU_Enable_TIM3_Clock(void);
    /**< Function to enable  TIM4 rcc clock*/
    void FMKCPU_Enable_TIM4_Clock(void);
    /**< Function to enable  TIM5 rcc clock*/
    void FMKCPU_Enable_TIM5_Clock(void);
    /**< Function to enable  TIM6 rcc clock*/
    void FMKCPU_Enable_TIM6_Clock(void);
    /**< Function to enable  TIM7 rcc clock*/
    void FMKCPU_Enable_TIM7_Clock(void);
    /**< Function to enable  TIM8 rcc clock*/
    void FMKCPU_Enable_TIM8_Clock(void);
    /**< Function to enable  UART4 rcc clock*/
    void FMKCPU_Enable_UART4_Clock(void);
    /**< Function to enable  UART5 rcc clock*/
    void FMKCPU_Enable_UART5_Clock(void);
    /**< Function to enable  UART7 rcc clock*/
    void FMKCPU_Enable_UART7_Clock(void);
    /**< Function to enable  UART8 rcc clock*/
    void FMKCPU_Enable_UART8_Clock(void);
    /**< Function to enable  USART1 rcc clock*/
    void FMKCPU_Enable_USART1_Clock(void);
    /**< Function to enable  USART2 rcc clock*/
    void FMKCPU_Enable_USART2_Clock(void);
    /**< Function to enable  USART3 rcc clock*/
    void FMKCPU_Enable_USART3_Clock(void);
    /**< Function to enable  USART6 rcc clock*/
    void FMKCPU_Enable_USART6_Clock(void);
    /**< Function to enable  USB1_OTG_HS rcc clock*/
    void FMKCPU_Enable_USB1_OTG_HS_Clock(void);
    /**< Function to enable  USB1_OTG_HS_ULPI rcc clock*/
    void FMKCPU_Enable_USB1_OTG_HS_ULPI_Clock(void);
    /**< Function to enable  VREF rcc clock*/
    void FMKCPU_Enable_VREF_Clock(void);
    /**< Function to enable  WWDG1 rcc clock*/
    void FMKCPU_Enable_WWDG1_Clock(void);
    /* CAUTION : Automatic generated code section for Enable Clk Declaration: End */

    /* CAUTION : Automatic generated code section for Disable Clk Declaration: Start */
    /**< Function to disable ADC12 rcc clock*/
    void FMKCPU_Disable_ADC12_Clock(void);
    /**< Function to disable ADC3 rcc clock*/
    void FMKCPU_Disable_ADC3_Clock(void);
    /**< Function to disable BDMA rcc clock*/
    void FMKCPU_Disable_BDMA_Clock(void);
    /**< Function to disable BKPRAM rcc clock*/
    void FMKCPU_Disable_BKPRAM_Clock(void);
    /**< Function to disable CEC rcc clock*/
    void FMKCPU_Disable_CEC_Clock(void);
    /**< Function to disable COMP12 rcc clock*/
    void FMKCPU_Disable_COMP12_Clock(void);
    /**< Function to disable CRC rcc clock*/
    void FMKCPU_Disable_CRC_Clock(void);
    /**< Function to disable CRS rcc clock*/
    void FMKCPU_Disable_CRS_Clock(void);
    /**< Function to disable CRYP rcc clock*/
    void FMKCPU_Disable_CRYP_Clock(void);
    /**< Function to disable D2SRAM1 rcc clock*/
    void FMKCPU_Disable_D2SRAM1_Clock(void);
    /**< Function to disable D2SRAM2 rcc clock*/
    void FMKCPU_Disable_D2SRAM2_Clock(void);
    /**< Function to disable D2SRAM3 rcc clock*/
    void FMKCPU_Disable_D2SRAM3_Clock(void);
    /**< Function to disable DAC12 rcc clock*/
    void FMKCPU_Disable_DAC12_Clock(void);
    /**< Function to disable DCMI rcc clock*/
    void FMKCPU_Disable_DCMI_Clock(void);
    /**< Function to disable DFSDM1 rcc clock*/
    void FMKCPU_Disable_DFSDM1_Clock(void);
    /**< Function to disable DMA1 rcc clock*/
    void FMKCPU_Disable_DMA1_Clock(void);
    /**< Function to disable DMA2 rcc clock*/
    void FMKCPU_Disable_DMA2_Clock(void);
    /**< Function to disable DMA2D rcc clock*/
    void FMKCPU_Disable_DMA2D_Clock(void);
    /**< Function to disable ETH1MAC rcc clock*/
    void FMKCPU_Disable_ETH1MAC_Clock(void);
    /**< Function to disable ETH1RX rcc clock*/
    void FMKCPU_Disable_ETH1RX_Clock(void);
    /**< Function to disable ETH1TX rcc clock*/
    void FMKCPU_Disable_ETH1TX_Clock(void);
    /**< Function to disable FDCAN rcc clock*/
    void FMKCPU_Disable_FDCAN_Clock(void);
    /**< Function to disable FMC rcc clock*/
    void FMKCPU_Disable_FMC_Clock(void);
    /**< Function to disable GPIOA rcc clock*/
    void FMKCPU_Disable_GPIOA_Clock(void);
    /**< Function to disable GPIOB rcc clock*/
    void FMKCPU_Disable_GPIOB_Clock(void);
    /**< Function to disable GPIOC rcc clock*/
    void FMKCPU_Disable_GPIOC_Clock(void);
    /**< Function to disable GPIOD rcc clock*/
    void FMKCPU_Disable_GPIOD_Clock(void);
    /**< Function to disable GPIOE rcc clock*/
    void FMKCPU_Disable_GPIOE_Clock(void);
    /**< Function to disable GPIOF rcc clock*/
    void FMKCPU_Disable_GPIOF_Clock(void);
    /**< Function to disable GPIOG rcc clock*/
    void FMKCPU_Disable_GPIOG_Clock(void);
    /**< Function to disable GPIOH rcc clock*/
    void FMKCPU_Disable_GPIOH_Clock(void);
    /**< Function to disable GPIOI rcc clock*/
    void FMKCPU_Disable_GPIOI_Clock(void);
    /**< Function to disable GPIOJ rcc clock*/
    void FMKCPU_Disable_GPIOJ_Clock(void);
    /**< Function to disable GPIOK rcc clock*/
    void FMKCPU_Disable_GPIOK_Clock(void);
    /**< Function to disable HASH rcc clock*/
    void FMKCPU_Disable_HASH_Clock(void);
    /**< Function to disable HRTIM1 rcc clock*/
    void FMKCPU_Disable_HRTIM1_Clock(void);
    /**< Function to disable HSEM rcc clock*/
    void FMKCPU_Disable_HSEM_Clock(void);
    /**< Function to disable I2C1 rcc clock*/
    void FMKCPU_Disable_I2C1_Clock(void);
    /**< Function to disable I2C2 rcc clock*/
    void FMKCPU_Disable_I2C2_Clock(void);
    /**< Function to disable I2C3 rcc clock*/
    void FMKCPU_Disable_I2C3_Clock(void);
    /**< Function to disable I2C4 rcc clock*/
    void FMKCPU_Disable_I2C4_Clock(void);
    /**< Function to disable JPGDECEN rcc clock*/
    void FMKCPU_Disable_JPGDECEN_Clock(void);
    /**< Function to disable LPTIM1 rcc clock*/
    void FMKCPU_Disable_LPTIM1_Clock(void);
    /**< Function to disable LPTIM2 rcc clock*/
    void FMKCPU_Disable_LPTIM2_Clock(void);
    /**< Function to disable LPTIM3 rcc clock*/
    void FMKCPU_Disable_LPTIM3_Clock(void);
    /**< Function to disable LPTIM4 rcc clock*/
    void FMKCPU_Disable_LPTIM4_Clock(void);
    /**< Function to disable LPTIM5 rcc clock*/
    void FMKCPU_Disable_LPTIM5_Clock(void);
    /**< Function to disable LPUART1 rcc clock*/
    void FMKCPU_Disable_LPUART1_Clock(void);
    /**< Function to disable LTDC rcc clock*/
    void FMKCPU_Disable_LTDC_Clock(void);
    /**< Function to disable MDIOS rcc clock*/
    void FMKCPU_Disable_MDIOS_Clock(void);
    /**< Function to disable MDMA rcc clock*/
    void FMKCPU_Disable_MDMA_Clock(void);
    /**< Function to disable OPAMP rcc clock*/
    void FMKCPU_Disable_OPAMP_Clock(void);
    /**< Function to disable QSPI rcc clock*/
    void FMKCPU_Disable_QSPI_Clock(void);
    /**< Function to disable RNG rcc clock*/
    void FMKCPU_Disable_RNG_Clock(void);
    /**< Function to disable RTC rcc clock*/
    void FMKCPU_Disable_RTC_Clock(void);
    /**< Function to disable SAI1 rcc clock*/
    void FMKCPU_Disable_SAI1_Clock(void);
    /**< Function to disable SAI2 rcc clock*/
    void FMKCPU_Disable_SAI2_Clock(void);
    /**< Function to disable SAI3 rcc clock*/
    void FMKCPU_Disable_SAI3_Clock(void);
    /**< Function to disable SAI4 rcc clock*/
    void FMKCPU_Disable_SAI4_Clock(void);
    /**< Function to disable SDMMC1 rcc clock*/
    void FMKCPU_Disable_SDMMC1_Clock(void);
    /**< Function to disable SDMMC2 rcc clock*/
    void FMKCPU_Disable_SDMMC2_Clock(void);
    /**< Function to disable SPDIFRX rcc clock*/
    void FMKCPU_Disable_SPDIFRX_Clock(void);
    /**< Function to disable SPI1 rcc clock*/
    void FMKCPU_Disable_SPI1_Clock(void);
    /**< Function to disable SPI2 rcc clock*/
    void FMKCPU_Disable_SPI2_Clock(void);
    /**< Function to disable SPI3 rcc clock*/
    void FMKCPU_Disable_SPI3_Clock(void);
    /**< Function to disable SPI4 rcc clock*/
    void FMKCPU_Disable_SPI4_Clock(void);
    /**< Function to disable SPI5 rcc clock*/
    void FMKCPU_Disable_SPI5_Clock(void);
    /**< Function to disable SPI6 rcc clock*/
    void FMKCPU_Disable_SPI6_Clock(void);
    /**< Function to disable SWPMI1 rcc clock*/
    void FMKCPU_Disable_SWPMI1_Clock(void);
    /**< Function to disable SYSCFG rcc clock*/
    void FMKCPU_Disable_SYSCFG_Clock(void);
    /**< Function to disable TIM1 rcc clock*/
    void FMKCPU_Disable_TIM1_Clock(void);
    /**< Function to disable TIM12 rcc clock*/
    void FMKCPU_Disable_TIM12_Clock(void);
    /**< Function to disable TIM13 rcc clock*/
    void FMKCPU_Disable_TIM13_Clock(void);
    /**< Function to disable TIM14 rcc clock*/
    void FMKCPU_Disable_TIM14_Clock(void);
    /**< Function to disable TIM15 rcc clock*/
    void FMKCPU_Disable_TIM15_Clock(void);
    /**< Function to disable TIM16 rcc clock*/
    void FMKCPU_Disable_TIM16_Clock(void);
    /**< Function to disable TIM17 rcc clock*/
    void FMKCPU_Disable_TIM17_Clock(void);
    /**< Function to disable TIM2 rcc clock*/
    void FMKCPU_Disable_TIM2_Clock(void);
    /**< Function to disable TIM3 rcc clock*/
    void FMKCPU_Disable_TIM3_Clock(void);
    /**< Function to disable TIM4 rcc clock*/
    void FMKCPU_Disable_TIM4_Clock(void);
    /**< Function to disable TIM5 rcc clock*/
    void FMKCPU_Disable_TIM5_Clock(void);
    /**< Function to disable TIM6 rcc clock*/
    void FMKCPU_Disable_TIM6_Clock(void);
    /**< Function to disable TIM7 rcc clock*/
    void FMKCPU_Disable_TIM7_Clock(void);
    /**< Function to disable TIM8 rcc clock*/
    void FMKCPU_Disable_TIM8_Clock(void);
    /**< Function to disable UART4 rcc clock*/
    void FMKCPU_Disable_UART4_Clock(void);
    /**< Function to disable UART5 rcc clock*/
    void FMKCPU_Disable_UART5_Clock(void);
    /**< Function to disable UART7 rcc clock*/
    void FMKCPU_Disable_UART7_Clock(void);
    /**< Function to disable UART8 rcc clock*/
    void FMKCPU_Disable_UART8_Clock(void);
    /**< Function to disable USART1 rcc clock*/
    void FMKCPU_Disable_USART1_Clock(void);
    /**< Function to disable USART2 rcc clock*/
    void FMKCPU_Disable_USART2_Clock(void);
    /**< Function to disable USART3 rcc clock*/
    void FMKCPU_Disable_USART3_Clock(void);
    /**< Function to disable USART6 rcc clock*/
    void FMKCPU_Disable_USART6_Clock(void);
    /**< Function to disable USB1_OTG_HS rcc clock*/
    void FMKCPU_Disable_USB1_OTG_HS_Clock(void);
    /**< Function to disable USB1_OTG_HS_ULPI rcc clock*/
    void FMKCPU_Disable_USB1_OTG_HS_ULPI_Clock(void);
    /**< Function to disable VREF rcc clock*/
    void FMKCPU_Disable_VREF_Clock(void);
    /**< Function to disable WWDG1 rcc clock*/
    void FMKCPU_Disable_WWDG1_Clock(void);
    /* CAUTION : Automatic generated code section for Disable Clk Declaration: End */

#endif // FMKPU_CONFIGSPECIFIC_H_INCLUDED           
//************************************************************************************
// End of File
//************************************************************************************

/**
 *
 *	@brief
 *	@note   
 *
 *
 *	@params[in] 
 *	@params[out]
 *	 
 *
 *
 */
