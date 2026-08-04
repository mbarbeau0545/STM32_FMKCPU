/*********************************************************************
 * @file        FMKCPU_ConfigSpecific.c
 * @brief       Template_BriefDescription.
 * @note        TemplateDetailsDescription.\n
 *
 * @author      xxxxxx
 * @date        jj/mm/yyyy
 * @version     1.0
 */






// ********************************************************************
// *                      Includes
// ********************************************************************
#include <math.h>
#include "./FMKCPU_ConfigSpecific.h"
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
//                      Local functions - Prototypes
//********************************************************************************

//********************************************************************************
//                      Public functions - Prototypes
//********************************************************************************
/*********************************
 * FMKCPU_Set_BspSystemClockCfg
 *********************************/
t_eReturnCode FMKCPU_Set_BspSystemClockCfg( RCC_OscInitTypeDef *f_RccOscCfg_ps,
                                            RCC_ClkInitTypeDef *f_RccClkCfg_ps,
                                            const t_sFMKCPU_SysOscCfg *f_sysOscCfg_ps,
                                            const t_sFMKCPU_PllOscCfg *f_pll1OscCfg_ps)
{
    t_eReturnCode Ret_e;

    if( (f_RccOscCfg_ps == (RCC_OscInitTypeDef *)NULL)
    ||  (f_RccClkCfg_ps == (RCC_ClkInitTypeDef *)NULL)
    ||  (f_sysOscCfg_ps == (const t_sFMKCPU_SysOscCfg *)NULL)
    ||  (f_pll1OscCfg_ps == (const t_sFMKCPU_PllOscCfg *)NULL))
    {
        Ret_e = RC_ERROR_PTR_NULL;
    }
    else
    {
        Ret_e = RC_OK;

        f_RccOscCfg_ps->OscillatorType = RCC_OSCILLATORTYPE_HSI | RCC_OSCILLATORTYPE_LSI;
        f_RccOscCfg_ps->HSIState = RCC_HSI_ON;
        f_RccOscCfg_ps->HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
        f_RccOscCfg_ps->PLL.PLLState = RCC_PLL_ON;
        f_RccOscCfg_ps->LSIState = RCC_LSI_ON;
        f_RccOscCfg_ps->PLL.PLLSource = RCC_PLLSOURCE_HSI;
        f_RccOscCfg_ps->PLL.PLLM = f_pll1OscCfg_ps->PLLM_Divider_u32;
        f_RccOscCfg_ps->PLL.PLLN = f_pll1OscCfg_ps->PPLN_Multplier_u32;
        f_RccOscCfg_ps->PLL.PLLP = f_pll1OscCfg_ps->PLLP_Divider_u32;
        f_RccOscCfg_ps->PLL.PLLQ = f_pll1OscCfg_ps->PLLQ_Divider_u32;
        f_RccOscCfg_ps->PLL.PLLR = f_pll1OscCfg_ps->PLLR_Divider_u32;

#ifdef FMKCPU_STM32_ECU_FAMILY_G4
        f_RccClkCfg_ps->ClockType      = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                                        |RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
        f_RccClkCfg_ps->SYSCLKSource   = RCC_SYSCLKSOURCE_PLLCLK;
        f_RccClkCfg_ps->AHBCLKDivider  = f_sysOscCfg_ps->AHB_Divider_u32;
        f_RccClkCfg_ps->APB1CLKDivider = f_sysOscCfg_ps->APB1_Divider_u32;
        f_RccClkCfg_ps->APB2CLKDivider = f_sysOscCfg_ps->APB2_Divider_u32;
#elif defined FMKCPU_STM32_ECU_FAMILY_H7
        f_RccOscCfg_ps->PLL.PLLRGE = f_pll1OscCfg_ps->PLL_RGE_Range_u32;
        f_RccOscCfg_ps->PLL.PLLVCOSEL = f_pll1OscCfg_ps->PLL_VCOSEL_u32;
        f_RccOscCfg_ps->PLL.PLLFRACN = f_pll1OscCfg_ps->PLL_FRACN_u32;

        f_RccClkCfg_ps->ClockType      = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                                        | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2
                                        | RCC_CLOCKTYPE_D3PCLK1|RCC_CLOCKTYPE_D1PCLK1;
        f_RccClkCfg_ps->SYSCLKSource   = RCC_SYSCLKSOURCE_PLLCLK;
        f_RccClkCfg_ps->SYSCLKDivider  = f_sysOscCfg_ps->SysClk_Divider_u32;
        f_RccClkCfg_ps->AHBCLKDivider  = f_sysOscCfg_ps->AHB_Divider_u32;
        f_RccClkCfg_ps->APB1CLKDivider = f_sysOscCfg_ps->APB1_Divider_u32;
        f_RccClkCfg_ps->APB2CLKDivider = f_sysOscCfg_ps->APB2_Divider_u32;
        f_RccClkCfg_ps->APB3CLKDivider = f_sysOscCfg_ps->APB3_Divider_u32;
        f_RccClkCfg_ps->APB4CLKDivider = f_sysOscCfg_ps->APB4_Divider_u32;
#elif defined FMKCPU_STM32_ECU_FAMILY_F
        f_RccOscCfg_ps->OscillatorType = RCC_OSCILLATORTYPE_HSI;
        f_RccOscCfg_ps->HSIState = RCC_HSI_ON;
        f_RccOscCfg_ps->HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
        f_RccOscCfg_ps->PLL.PLLState = RCC_PLL_NONE;
#else
        #error("Unknown Stm32 Family")
#endif
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_Set_BspHardwareInitBeforeHal
 *********************************/
t_eReturnCode FMKCPU_Set_BspHardwareInitBeforeHal(void)
{
#if defined(FMKCPU_STM32_ECU_FAMILY_H7)
    MPU_Region_InitTypeDef MPU_InitStruct = {0};

    HAL_MPU_Disable();

    MPU_InitStruct.Enable = MPU_REGION_ENABLE;
    MPU_InitStruct.Number = MPU_REGION_NUMBER0;
    MPU_InitStruct.BaseAddress = 0x0;
    MPU_InitStruct.Size = MPU_REGION_SIZE_4GB;
    MPU_InitStruct.SubRegionDisable = 0x87;
    MPU_InitStruct.TypeExtField = MPU_TEX_LEVEL0;
    MPU_InitStruct.AccessPermission = MPU_REGION_NO_ACCESS;
    MPU_InitStruct.DisableExec = MPU_INSTRUCTION_ACCESS_DISABLE;
    MPU_InitStruct.IsShareable = MPU_ACCESS_SHAREABLE;
    MPU_InitStruct.IsCacheable = MPU_ACCESS_NOT_CACHEABLE;
    MPU_InitStruct.IsBufferable = MPU_ACCESS_NOT_BUFFERABLE;

    HAL_MPU_ConfigRegion(&MPU_InitStruct);
    HAL_MPU_Enable(MPU_PRIVILEGED_DEFAULT);
#endif

    return RC_OK;
}

/*********************************
 * FMKCPU_Set_BspHardwareInitAfterHal
 *********************************/
t_eReturnCode FMKCPU_Set_BspHardwareInitAfterHal(void)
{
    t_eReturnCode Ret_e = RC_OK;
    HAL_StatusTypeDef bspRet_e = HAL_OK;

#if defined(FMKCPU_STM32_ECU_FAMILY_G4)
    Ret_e = FMKCPU_Set_HwClock(FMKCPU_RCC_CLK_SYSCFG, FMKCPU_CLOCKPORT_OPE_ENABLE);

    if(Ret_e == RC_OK)
    {
        Ret_e = FMKCPU_Set_HwClock(FMKCPU_RCC_CLK_PWR, FMKCPU_CLOCKPORT_OPE_ENABLE);
    }
    if(Ret_e == RC_OK)
    {
        HAL_PWREx_DisableUCPDDeadBattery();
    }
#elif defined(FMKCPU_STM32_ECU_FAMILY_H7)
    Ret_e = FMKCPU_Set_HwClock(FMKCPU_RCC_CLK_SYSCFG, FMKCPU_CLOCKPORT_OPE_ENABLE);

    if(Ret_e == RC_OK)
    {
        bspRet_e = HAL_PWREx_ConfigSupply(PWR_LDO_SUPPLY);

        if(bspRet_e != HAL_OK)
        {
            Ret_e = RC_ERROR_WRONG_RESULT;
        }
    }
#endif

    return Ret_e;
}

/*********************************
 * FMKCPU_CheckResetCpuFlagSpecific
 *********************************/
t_eReturnCode FMKCPU_CheckResetCpuFlagSpecific(t_eFMKCPU_CpuResetFlag *f_resetFlag_pe)
{
    t_eReturnCode Ret_e;

    if(f_resetFlag_pe == (t_eFMKCPU_CpuResetFlag *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
    }
    else
    {
        Ret_e = RC_OK;

#if defined(FMKCPU_STM32_ECU_FAMILY_G4)
        if(__HAL_RCC_GET_FLAG(RCC_FLAG_OBLRST))
        {
            *f_resetFlag_pe = FMKCPU_RESET_CAUSE_OBLRST;
            FMKSRL_LOG("[RESET] Option Byte Loader Reset (OBLRST)\n");
        }
        if(__HAL_RCC_GET_FLAG(RCC_FLAG_IWDGRST))
        {
            *f_resetFlag_pe = FMKCPU_RESET_CAUSE_IWDRST;
            FMKSRL_LOG("[RESET] Independent Watchdog Reset (IWDGRST)\n");
        }
        if(__HAL_RCC_GET_FLAG(RCC_FLAG_WWDGRST))
        {
            *f_resetFlag_pe = FMKCPU_RESET_CAUSE_WWDRST;
            FMKSRL_LOG("[RESET] Window Watchdog Reset (WWDGRST)\n");
        }
        if(__HAL_RCC_GET_FLAG(RCC_FLAG_LPWRRST))
        {
            *f_resetFlag_pe = FMKCPU_RESET_CAUSE_LPWRRST;
            FMKSRL_LOG("[RESET] Low Power Reset (LPWRRST)\n");
        }
#endif
    }

    return Ret_e;
}

/***********************************
 * FMKCPU_SetRequestType
 ***********************************/
t_eReturnCode FMKCPU_SetRequestType(t_eFMKCPU_DmaRqst f_RqstType_e,
                                    DMA_HandleTypeDef * f_bspDma_ps)
{
    t_eReturnCode Ret_e = RC_OK;

    if(f_RqstType_e >= FMKCPU_DMA_RQSTYPE_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
    }
    if(f_bspDma_ps == (DMA_HandleTypeDef *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
    }
    if(Ret_e == RC_OK)
    {
        switch (f_RqstType_e)
        {   
            /* CAUTION : Automatic generated code section for Request Dma: Start */
            case FMKCPU_DMA_RQSTYPE_ADC1:
                f_bspDma_ps->Init.Request = DMA_REQUEST_ADC1;
                break;
            case FMKCPU_DMA_RQSTYPE_ADC3:
                f_bspDma_ps->Init.Request = DMA_REQUEST_ADC3;
                break;
            case FMKCPU_DMA_RQSTYPE_USART2_RX:
                f_bspDma_ps->Init.Request = DMA_REQUEST_USART2_RX;
                break;
            case FMKCPU_DMA_RQSTYPE_USART2_TX:
                f_bspDma_ps->Init.Request = DMA_REQUEST_USART2_TX;
                break;
            case FMKCPU_DMA_RQSTYPE_USART1_RX:
                f_bspDma_ps->Init.Request = DMA_REQUEST_USART1_RX;
                break;
            case FMKCPU_DMA_RQSTYPE_USART1_TX:
                f_bspDma_ps->Init.Request = DMA_REQUEST_USART1_TX;
                break;
            case FMKCPU_DMA_RQSTYPE_USART6_RX:
                f_bspDma_ps->Init.Request = DMA_REQUEST_USART6_RX;
                break;
            case FMKCPU_DMA_RQSTYPE_USART6_TX:
                f_bspDma_ps->Init.Request = DMA_REQUEST_USART6_TX;
                break;
            case FMKCPU_DMA_RQSTYPE_ADC2:
                f_bspDma_ps->Init.Request = DMA_REQUEST_ADC2;
                break;
            /* CAUTION : Automatic generated code section for Request Dma: End */

            case FMKCPU_DMA_RQSTYPE_NB:
            default:
                Ret_e = RC_ERROR_NOT_SUPPORTED;
                break;
        }
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_Get_BspIRQNType
 *********************************/
t_eReturnCode FMKCPU_Get_BspIRQNType(t_eFMKCPU_IRQNType f_IRQN_e, IRQn_Type *f_bspIRQN_pe)
{
    t_eReturnCode Ret_e = RC_OK;

    if(f_IRQN_e >= FMKCPU_NVIC_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
    }
    if(f_bspIRQN_pe == (IRQn_Type *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
    }
    if(Ret_e == RC_OK)
    {
        switch (f_IRQN_e)
        {
            /* CAUTION : Automatic generated code section for IRQNType switch case: Start */
            case FMKCPU_NVIC_ADC_IRQN:
                *f_bspIRQN_pe = ADC_IRQn;
                break;
            case FMKCPU_NVIC_ADC3_IRQN:
                *f_bspIRQN_pe = ADC3_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL0_IRQN:
                *f_bspIRQN_pe = BDMA_Channel0_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL1_IRQN:
                *f_bspIRQN_pe = BDMA_Channel1_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL2_IRQN:
                *f_bspIRQN_pe = BDMA_Channel2_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL3_IRQN:
                *f_bspIRQN_pe = BDMA_Channel3_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL4_IRQN:
                *f_bspIRQN_pe = BDMA_Channel4_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL5_IRQN:
                *f_bspIRQN_pe = BDMA_Channel5_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL6_IRQN:
                *f_bspIRQN_pe = BDMA_Channel6_IRQn;
                break;
            case FMKCPU_NVIC_BDMA_CHANNEL7_IRQN:
                *f_bspIRQN_pe = BDMA_Channel7_IRQn;
                break;
            case FMKCPU_NVIC_CEC_IRQN:
                *f_bspIRQN_pe = CEC_IRQn;
                break;
            case FMKCPU_NVIC_COMP_IRQN:
                *f_bspIRQN_pe = COMP_IRQn;
                break;
            case FMKCPU_NVIC_CRS_IRQN:
                *f_bspIRQN_pe = CRS_IRQn;
                break;
            case FMKCPU_NVIC_CRYP_IRQN:
                *f_bspIRQN_pe = CRYP_IRQn;
                break;
            case FMKCPU_NVIC_DCMI_IRQN:
                *f_bspIRQN_pe = DCMI_IRQn;
                break;
            case FMKCPU_NVIC_DFSDM1_FLT0_IRQN:
                *f_bspIRQN_pe = DFSDM1_FLT0_IRQn;
                break;
            case FMKCPU_NVIC_DFSDM1_FLT1_IRQN:
                *f_bspIRQN_pe = DFSDM1_FLT1_IRQn;
                break;
            case FMKCPU_NVIC_DFSDM1_FLT2_IRQN:
                *f_bspIRQN_pe = DFSDM1_FLT2_IRQn;
                break;
            case FMKCPU_NVIC_DFSDM1_FLT3_IRQN:
                *f_bspIRQN_pe = DFSDM1_FLT3_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM0_IRQN:
                *f_bspIRQN_pe = DMA1_Stream0_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM1_IRQN:
                *f_bspIRQN_pe = DMA1_Stream1_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM2_IRQN:
                *f_bspIRQN_pe = DMA1_Stream2_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM3_IRQN:
                *f_bspIRQN_pe = DMA1_Stream3_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM4_IRQN:
                *f_bspIRQN_pe = DMA1_Stream4_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM5_IRQN:
                *f_bspIRQN_pe = DMA1_Stream5_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM6_IRQN:
                *f_bspIRQN_pe = DMA1_Stream6_IRQn;
                break;
            case FMKCPU_NVIC_DMA1_STREAM7_IRQN:
                *f_bspIRQN_pe = DMA1_Stream7_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM0_IRQN:
                *f_bspIRQN_pe = DMA2_Stream0_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM1_IRQN:
                *f_bspIRQN_pe = DMA2_Stream1_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM2_IRQN:
                *f_bspIRQN_pe = DMA2_Stream2_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM3_IRQN:
                *f_bspIRQN_pe = DMA2_Stream3_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM4_IRQN:
                *f_bspIRQN_pe = DMA2_Stream4_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM5_IRQN:
                *f_bspIRQN_pe = DMA2_Stream5_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM6_IRQN:
                *f_bspIRQN_pe = DMA2_Stream6_IRQn;
                break;
            case FMKCPU_NVIC_DMA2_STREAM7_IRQN:
                *f_bspIRQN_pe = DMA2_Stream7_IRQn;
                break;
            case FMKCPU_NVIC_DMA2D_IRQN:
                *f_bspIRQN_pe = DMA2D_IRQn;
                break;
            case FMKCPU_NVIC_DMAMUX1_OVR_IRQN:
                *f_bspIRQN_pe = DMAMUX1_OVR_IRQn;
                break;
            case FMKCPU_NVIC_DMAMUX2_OVR_IRQN:
                *f_bspIRQN_pe = DMAMUX2_OVR_IRQn;
                break;
            case FMKCPU_NVIC_ECC_IRQN:
                *f_bspIRQN_pe = ECC_IRQn;
                break;
            case FMKCPU_NVIC_ETH_IRQN:
                *f_bspIRQN_pe = ETH_IRQn;
                break;
            case FMKCPU_NVIC_ETH_WKUP_IRQN:
                *f_bspIRQN_pe = ETH_WKUP_IRQn;
                break;
            case FMKCPU_NVIC_EXTI0_IRQN:
                *f_bspIRQN_pe = EXTI0_IRQn;
                break;
            case FMKCPU_NVIC_EXTI1_IRQN:
                *f_bspIRQN_pe = EXTI1_IRQn;
                break;
            case FMKCPU_NVIC_EXTI15_10_IRQN:
                *f_bspIRQN_pe = EXTI15_10_IRQn;
                break;
            case FMKCPU_NVIC_EXTI2_IRQN:
                *f_bspIRQN_pe = EXTI2_IRQn;
                break;
            case FMKCPU_NVIC_EXTI3_IRQN:
                *f_bspIRQN_pe = EXTI3_IRQn;
                break;
            case FMKCPU_NVIC_EXTI4_IRQN:
                *f_bspIRQN_pe = EXTI4_IRQn;
                break;
            case FMKCPU_NVIC_EXTI9_5_IRQN:
                *f_bspIRQN_pe = EXTI9_5_IRQn;
                break;
            case FMKCPU_NVIC_FDCAN_CAL_IRQN:
                *f_bspIRQN_pe = FDCAN_CAL_IRQn;
                break;
            case FMKCPU_NVIC_FDCAN1_IT0_IRQN:
                *f_bspIRQN_pe = FDCAN1_IT0_IRQn;
                break;
            case FMKCPU_NVIC_FDCAN1_IT1_IRQN:
                *f_bspIRQN_pe = FDCAN1_IT1_IRQn;
                break;
            case FMKCPU_NVIC_FDCAN2_IT0_IRQN:
                *f_bspIRQN_pe = FDCAN2_IT0_IRQn;
                break;
            case FMKCPU_NVIC_FDCAN2_IT1_IRQN:
                *f_bspIRQN_pe = FDCAN2_IT1_IRQn;
                break;
            case FMKCPU_NVIC_FLASH_IRQN:
                *f_bspIRQN_pe = FLASH_IRQn;
                break;
            case FMKCPU_NVIC_FMC_IRQN:
                *f_bspIRQN_pe = FMC_IRQn;
                break;
            case FMKCPU_NVIC_FPU_IRQN:
                *f_bspIRQN_pe = FPU_IRQn;
                break;
            case FMKCPU_NVIC_HASH_RNG_IRQN:
                *f_bspIRQN_pe = HASH_RNG_IRQn;
                break;
            case FMKCPU_NVIC_HRTIM1_FLT_IRQN:
                *f_bspIRQN_pe = HRTIM1_FLT_IRQn;
                break;
            case FMKCPU_NVIC_HRTIM1_MASTER_IRQN:
                *f_bspIRQN_pe = HRTIM1_Master_IRQn;
                break;
            case FMKCPU_NVIC_HRTIM1_TIMA_IRQN:
                *f_bspIRQN_pe = HRTIM1_TIMA_IRQn;
                break;
            case FMKCPU_NVIC_HRTIM1_TIMB_IRQN:
                *f_bspIRQN_pe = HRTIM1_TIMB_IRQn;
                break;
            case FMKCPU_NVIC_HRTIM1_TIMC_IRQN:
                *f_bspIRQN_pe = HRTIM1_TIMC_IRQn;
                break;
            case FMKCPU_NVIC_HRTIM1_TIMD_IRQN:
                *f_bspIRQN_pe = HRTIM1_TIMD_IRQn;
                break;
            case FMKCPU_NVIC_HRTIM1_TIME_IRQN:
                *f_bspIRQN_pe = HRTIM1_TIME_IRQn;
                break;
            case FMKCPU_NVIC_HSEM1_IRQN:
                *f_bspIRQN_pe = HSEM1_IRQn;
                break;
            case FMKCPU_NVIC_I2C1_ER_IRQN:
                *f_bspIRQN_pe = I2C1_ER_IRQn;
                break;
            case FMKCPU_NVIC_I2C1_EV_IRQN:
                *f_bspIRQN_pe = I2C1_EV_IRQn;
                break;
            case FMKCPU_NVIC_I2C2_ER_IRQN:
                *f_bspIRQN_pe = I2C2_ER_IRQn;
                break;
            case FMKCPU_NVIC_I2C2_EV_IRQN:
                *f_bspIRQN_pe = I2C2_EV_IRQn;
                break;
            case FMKCPU_NVIC_I2C3_ER_IRQN:
                *f_bspIRQN_pe = I2C3_ER_IRQn;
                break;
            case FMKCPU_NVIC_I2C3_EV_IRQN:
                *f_bspIRQN_pe = I2C3_EV_IRQn;
                break;
            case FMKCPU_NVIC_I2C4_ER_IRQN:
                *f_bspIRQN_pe = I2C4_ER_IRQn;
                break;
            case FMKCPU_NVIC_I2C4_EV_IRQN:
                *f_bspIRQN_pe = I2C4_EV_IRQn;
                break;
            case FMKCPU_NVIC_JPEG_IRQN:
                *f_bspIRQN_pe = JPEG_IRQn;
                break;
            case FMKCPU_NVIC_LPTIM1_IRQN:
                *f_bspIRQN_pe = LPTIM1_IRQn;
                break;
            case FMKCPU_NVIC_LPTIM2_IRQN:
                *f_bspIRQN_pe = LPTIM2_IRQn;
                break;
            case FMKCPU_NVIC_LPTIM3_IRQN:
                *f_bspIRQN_pe = LPTIM3_IRQn;
                break;
            case FMKCPU_NVIC_LPTIM4_IRQN:
                *f_bspIRQN_pe = LPTIM4_IRQn;
                break;
            case FMKCPU_NVIC_LPTIM5_IRQN:
                *f_bspIRQN_pe = LPTIM5_IRQn;
                break;
            case FMKCPU_NVIC_LPUART1_IRQN:
                *f_bspIRQN_pe = LPUART1_IRQn;
                break;
            case FMKCPU_NVIC_LTDC_ER_IRQN:
                *f_bspIRQN_pe = LTDC_ER_IRQn;
                break;
            case FMKCPU_NVIC_LTDC_IRQN:
                *f_bspIRQN_pe = LTDC_IRQn;
                break;
            case FMKCPU_NVIC_MDIOS_IRQN:
                *f_bspIRQN_pe = MDIOS_IRQn;
                break;
            case FMKCPU_NVIC_MDIOS_WKUP_IRQN:
                *f_bspIRQN_pe = MDIOS_WKUP_IRQn;
                break;
            case FMKCPU_NVIC_MDMA_IRQN:
                *f_bspIRQN_pe = MDMA_IRQn;
                break;
            case FMKCPU_NVIC_OTG_FS_EP1_IN_IRQN:
                *f_bspIRQN_pe = OTG_FS_EP1_IN_IRQn;
                break;
            case FMKCPU_NVIC_OTG_FS_EP1_OUT_IRQN:
                *f_bspIRQN_pe = OTG_FS_EP1_OUT_IRQn;
                break;
            case FMKCPU_NVIC_OTG_FS_IRQN:
                *f_bspIRQN_pe = OTG_FS_IRQn;
                break;
            case FMKCPU_NVIC_OTG_FS_WKUP_IRQN:
                *f_bspIRQN_pe = OTG_FS_WKUP_IRQn;
                break;
            case FMKCPU_NVIC_OTG_HS_EP1_IN_IRQN:
                *f_bspIRQN_pe = OTG_HS_EP1_IN_IRQn;
                break;
            case FMKCPU_NVIC_OTG_HS_EP1_OUT_IRQN:
                *f_bspIRQN_pe = OTG_HS_EP1_OUT_IRQn;
                break;
            case FMKCPU_NVIC_OTG_HS_IRQN:
                *f_bspIRQN_pe = OTG_HS_IRQn;
                break;
            case FMKCPU_NVIC_OTG_HS_WKUP_IRQN:
                *f_bspIRQN_pe = OTG_HS_WKUP_IRQn;
                break;
            case FMKCPU_NVIC_PVD_AVD_IRQN:
                *f_bspIRQN_pe = PVD_AVD_IRQn;
                break;
            case FMKCPU_NVIC_QUADSPI_IRQN:
                *f_bspIRQN_pe = QUADSPI_IRQn;
                break;
            case FMKCPU_NVIC_RCC_IRQN:
                *f_bspIRQN_pe = RCC_IRQn;
                break;
            case FMKCPU_NVIC_RTC_ALARM_IRQN:
                *f_bspIRQN_pe = RTC_Alarm_IRQn;
                break;
            case FMKCPU_NVIC_RTC_WKUP_IRQN:
                *f_bspIRQN_pe = RTC_WKUP_IRQn;
                break;
            case FMKCPU_NVIC_SAI1_IRQN:
                *f_bspIRQN_pe = SAI1_IRQn;
                break;
            case FMKCPU_NVIC_SAI2_IRQN:
                *f_bspIRQN_pe = SAI2_IRQn;
                break;
            case FMKCPU_NVIC_SAI3_IRQN:
                *f_bspIRQN_pe = SAI3_IRQn;
                break;
            case FMKCPU_NVIC_SAI4_IRQN:
                *f_bspIRQN_pe = SAI4_IRQn;
                break;
            case FMKCPU_NVIC_SDMMC1_IRQN:
                *f_bspIRQN_pe = SDMMC1_IRQn;
                break;
            case FMKCPU_NVIC_SDMMC2_IRQN:
                *f_bspIRQN_pe = SDMMC2_IRQn;
                break;
            case FMKCPU_NVIC_SPDIF_RX_IRQN:
                *f_bspIRQN_pe = SPDIF_RX_IRQn;
                break;
            case FMKCPU_NVIC_SPI1_IRQN:
                *f_bspIRQN_pe = SPI1_IRQn;
                break;
            case FMKCPU_NVIC_SPI2_IRQN:
                *f_bspIRQN_pe = SPI2_IRQn;
                break;
            case FMKCPU_NVIC_SPI3_IRQN:
                *f_bspIRQN_pe = SPI3_IRQn;
                break;
            case FMKCPU_NVIC_SPI4_IRQN:
                *f_bspIRQN_pe = SPI4_IRQn;
                break;
            case FMKCPU_NVIC_SPI5_IRQN:
                *f_bspIRQN_pe = SPI5_IRQn;
                break;
            case FMKCPU_NVIC_SPI6_IRQN:
                *f_bspIRQN_pe = SPI6_IRQn;
                break;
            case FMKCPU_NVIC_SWPMI1_IRQN:
                *f_bspIRQN_pe = SWPMI1_IRQn;
                break;
            case FMKCPU_NVIC_TAMP_STAMP_IRQN:
                *f_bspIRQN_pe = TAMP_STAMP_IRQn;
                break;
            case FMKCPU_NVIC_TIM1_BRK_IRQN:
                *f_bspIRQN_pe = TIM1_BRK_IRQn;
                break;
            case FMKCPU_NVIC_TIM1_CC_IRQN:
                *f_bspIRQN_pe = TIM1_CC_IRQn;
                break;
            case FMKCPU_NVIC_TIM1_TRG_COM_IRQN:
                *f_bspIRQN_pe = TIM1_TRG_COM_IRQn;
                break;
            case FMKCPU_NVIC_TIM1_UP_IRQN:
                *f_bspIRQN_pe = TIM1_UP_IRQn;
                break;
            case FMKCPU_NVIC_TIM15_IRQN:
                *f_bspIRQN_pe = TIM15_IRQn;
                break;
            case FMKCPU_NVIC_TIM16_IRQN:
                *f_bspIRQN_pe = TIM16_IRQn;
                break;
            case FMKCPU_NVIC_TIM17_IRQN:
                *f_bspIRQN_pe = TIM17_IRQn;
                break;
            case FMKCPU_NVIC_TIM2_IRQN:
                *f_bspIRQN_pe = TIM2_IRQn;
                break;
            case FMKCPU_NVIC_TIM3_IRQN:
                *f_bspIRQN_pe = TIM3_IRQn;
                break;
            case FMKCPU_NVIC_TIM4_IRQN:
                *f_bspIRQN_pe = TIM4_IRQn;
                break;
            case FMKCPU_NVIC_TIM5_IRQN:
                *f_bspIRQN_pe = TIM5_IRQn;
                break;
            case FMKCPU_NVIC_TIM6_DAC_IRQN:
                *f_bspIRQN_pe = TIM6_DAC_IRQn;
                break;
            case FMKCPU_NVIC_TIM7_IRQN:
                *f_bspIRQN_pe = TIM7_IRQn;
                break;
            case FMKCPU_NVIC_TIM8_BRK_TIM12_IRQN:
                *f_bspIRQN_pe = TIM8_BRK_TIM12_IRQn;
                break;
            case FMKCPU_NVIC_TIM8_CC_IRQN:
                *f_bspIRQN_pe = TIM8_CC_IRQn;
                break;
            case FMKCPU_NVIC_TIM8_TRG_COM_TIM14_IRQN:
                *f_bspIRQN_pe = TIM8_TRG_COM_TIM14_IRQn;
                break;
            case FMKCPU_NVIC_TIM8_UP_TIM13_IRQN:
                *f_bspIRQN_pe = TIM8_UP_TIM13_IRQn;
                break;
            case FMKCPU_NVIC_UART4_IRQN:
                *f_bspIRQN_pe = UART4_IRQn;
                break;
            case FMKCPU_NVIC_UART5_IRQN:
                *f_bspIRQN_pe = UART5_IRQn;
                break;
            case FMKCPU_NVIC_UART7_IRQN:
                *f_bspIRQN_pe = UART7_IRQn;
                break;
            case FMKCPU_NVIC_UART8_IRQN:
                *f_bspIRQN_pe = UART8_IRQn;
                break;
            case FMKCPU_NVIC_USART1_IRQN:
                *f_bspIRQN_pe = USART1_IRQn;
                break;
            case FMKCPU_NVIC_USART2_IRQN:
                *f_bspIRQN_pe = USART2_IRQn;
                break;
            case FMKCPU_NVIC_USART3_IRQN:
                *f_bspIRQN_pe = USART3_IRQn;
                break;
            case FMKCPU_NVIC_USART6_IRQN:
                *f_bspIRQN_pe = USART6_IRQn;
                break;
            case FMKCPU_NVIC_WAKEUP_PIN_IRQN:
                *f_bspIRQN_pe = WAKEUP_PIN_IRQn;
                break;
            case FMKCPU_NVIC_WWDG_IRQN:
                *f_bspIRQN_pe = WWDG_IRQn;
                break;
            /* CAUTION : Automatic generated code section for IRQNType switch case: End */
            case FMKCPU_NVIC_NB:
            default:
            {
                Ret_e = RC_ERROR_NOT_ALLOWED;
            }

        }
    }
    return Ret_e;
}

#if defined(FMKCPU_STM32_ECU_FAMILY_G4) | defined(FMKCPU_STM32_ECU_FAMILY_H7)
/*********************************
 * FMKCPU_SetPeriphClockCfg
 *********************************/
t_eReturnCode FMKCPU_SetPeriphClockCfg(t_sFMKCPU_PllOscCfg ** f_PllOtherCfg_pas)
{
    t_eReturnCode Ret_e = RC_OK; 
    t_uint16 idxPeriphClk_u16;
    RCC_PeriphCLKInitTypeDef periphClkCfg_s = {0};
    HAL_StatusTypeDef bspRet_e = HAL_OK;

    //---- set the bsp Pll configuration according the confgiuration depending on the cortex ----//
#if defined(FMKCPU_STM32_ECU_FAMILY_H7)
    if(f_PllOtherCfg_pas != (t_sFMKCPU_PllOscCfg **)NULL)
    {
        periphClkCfg_s.PLL2.PLL2M       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PLLM_Divider_u32;
        periphClkCfg_s.PLL2.PLL2N       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PPLN_Multplier_u32;
        periphClkCfg_s.PLL2.PLL2P       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PLLP_Divider_u32;
        periphClkCfg_s.PLL2.PLL2Q       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PLLQ_Divider_u32;
        periphClkCfg_s.PLL2.PLL2R       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PLLR_Divider_u32;
        periphClkCfg_s.PLL2.PLL2RGE     = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PLL_RGE_Range_u32;
        periphClkCfg_s.PLL2.PLL2VCOSEL  = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PLL_VCOSEL_u32;
        periphClkCfg_s.PLL2.PLL2FRACN   = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_2]->PLL_FRACN_u32;

        periphClkCfg_s.PLL3.PLL3M       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PLLM_Divider_u32;
        periphClkCfg_s.PLL3.PLL3N       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PPLN_Multplier_u32;
        periphClkCfg_s.PLL3.PLL3P       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PLLP_Divider_u32;
        periphClkCfg_s.PLL3.PLL3Q       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PLLQ_Divider_u32;
        periphClkCfg_s.PLL3.PLL3R       = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PLLR_Divider_u32;
        periphClkCfg_s.PLL3.PLL3RGE     = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PLL_RGE_Range_u32;
        periphClkCfg_s.PLL3.PLL3VCOSEL  = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PLL_VCOSEL_u32;
        periphClkCfg_s.PLL3.PLL3FRACN   = f_PllOtherCfg_pas[FMKCPU_SYS_OSC_PLL_3]->PLL_FRACN_u32;
    }
    else 
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
    }
//#else nothing to do for G4 'cause only one PLL already configured
#endif // FMKCPU_STM32_ECU_FAMILY_H7

    periphClkCfg_s.PeriphClockSelection = (t_uint32)0;

    for(idxPeriphClk_u16 = (t_uint16)0 ; 
    (idxPeriphClk_u16 < FMKCPU_RCC_CLK_NB) ; 
    idxPeriphClk_u16++)
    {
        //--- reset RetCode ----//
        switch (idxPeriphClk_u16)
        {
            /* CAUTION : Automatic generated code section for Periph Clock Cfg: Start */
            case FMKCPU_RCC_CLK_ADC12:
                periphClkCfg_s.AdcClockSelection = RCC_ADCCLKSOURCE_PLL2;
                //------ Reference Clock  Source PLL2P ------//
                periphClkCfg_s.PeriphClockSelection |= RCC_PERIPHCLK_ADC;
                break;
            case FMKCPU_RCC_CLK_ADC3:
                periphClkCfg_s.AdcClockSelection = RCC_ADCCLKSOURCE_PLL2;
                //------ Reference Clock  Source PLL2P ------//
                periphClkCfg_s.PeriphClockSelection |= RCC_PERIPHCLK_ADC;
                break;
            case FMKCPU_RCC_CLK_FDCAN:
                periphClkCfg_s.FdcanClockSelection = RCC_FDCANCLKSOURCE_PLL;
                //------ Reference Clock  Source PLL1Q ------//
                periphClkCfg_s.PeriphClockSelection |= RCC_PERIPHCLK_FDCAN;
                break;
            case FMKCPU_RCC_CLK_BDMA:
            case FMKCPU_RCC_CLK_BKPRAM:
            case FMKCPU_RCC_CLK_CEC:
            case FMKCPU_RCC_CLK_COMP12:
            case FMKCPU_RCC_CLK_CRC:
            case FMKCPU_RCC_CLK_CRS:
            case FMKCPU_RCC_CLK_CRYP:
            case FMKCPU_RCC_CLK_D2SRAM1:
            case FMKCPU_RCC_CLK_D2SRAM2:
            case FMKCPU_RCC_CLK_D2SRAM3:
            case FMKCPU_RCC_CLK_DAC12:
            case FMKCPU_RCC_CLK_DCMI:
            case FMKCPU_RCC_CLK_DFSDM1:
            case FMKCPU_RCC_CLK_DMA1:
            case FMKCPU_RCC_CLK_DMA2:
            case FMKCPU_RCC_CLK_DMA2D:
            case FMKCPU_RCC_CLK_ETH1MAC:
            case FMKCPU_RCC_CLK_ETH1RX:
            case FMKCPU_RCC_CLK_ETH1TX:
            case FMKCPU_RCC_CLK_FMC:
            case FMKCPU_RCC_CLK_GPIOA:
            case FMKCPU_RCC_CLK_GPIOB:
            case FMKCPU_RCC_CLK_GPIOC:
            case FMKCPU_RCC_CLK_GPIOD:
            case FMKCPU_RCC_CLK_GPIOE:
            case FMKCPU_RCC_CLK_GPIOF:
            case FMKCPU_RCC_CLK_GPIOG:
            case FMKCPU_RCC_CLK_GPIOH:
            case FMKCPU_RCC_CLK_GPIOI:
            case FMKCPU_RCC_CLK_GPIOJ:
            case FMKCPU_RCC_CLK_GPIOK:
            case FMKCPU_RCC_CLK_HASH:
            case FMKCPU_RCC_CLK_HRTIM1:
            case FMKCPU_RCC_CLK_HSEM:
            case FMKCPU_RCC_CLK_I2C1:
            case FMKCPU_RCC_CLK_I2C2:
            case FMKCPU_RCC_CLK_I2C3:
            case FMKCPU_RCC_CLK_I2C4:
            case FMKCPU_RCC_CLK_JPGDECEN:
            case FMKCPU_RCC_CLK_LPTIM1:
            case FMKCPU_RCC_CLK_LPTIM2:
            case FMKCPU_RCC_CLK_LPTIM3:
            case FMKCPU_RCC_CLK_LPTIM4:
            case FMKCPU_RCC_CLK_LPTIM5:
            case FMKCPU_RCC_CLK_LPUART1:
            case FMKCPU_RCC_CLK_LTDC:
            case FMKCPU_RCC_CLK_MDIOS:
            case FMKCPU_RCC_CLK_MDMA:
            case FMKCPU_RCC_CLK_OPAMP:
            case FMKCPU_RCC_CLK_QSPI:
            case FMKCPU_RCC_CLK_RNG:
            case FMKCPU_RCC_CLK_RTC:
            case FMKCPU_RCC_CLK_SAI1:
            case FMKCPU_RCC_CLK_SAI2:
            case FMKCPU_RCC_CLK_SAI3:
            case FMKCPU_RCC_CLK_SAI4:
            case FMKCPU_RCC_CLK_SDMMC1:
            case FMKCPU_RCC_CLK_SDMMC2:
            case FMKCPU_RCC_CLK_SPDIFRX:
            case FMKCPU_RCC_CLK_SPI1:
            case FMKCPU_RCC_CLK_SPI2:
            case FMKCPU_RCC_CLK_SPI3:
            case FMKCPU_RCC_CLK_SPI4:
            case FMKCPU_RCC_CLK_SPI5:
            case FMKCPU_RCC_CLK_SPI6:
            case FMKCPU_RCC_CLK_SWPMI1:
            case FMKCPU_RCC_CLK_SYSCFG:
            case FMKCPU_RCC_CLK_TIM1:
            case FMKCPU_RCC_CLK_TIM12:
            case FMKCPU_RCC_CLK_TIM13:
            case FMKCPU_RCC_CLK_TIM14:
            case FMKCPU_RCC_CLK_TIM15:
            case FMKCPU_RCC_CLK_TIM16:
            case FMKCPU_RCC_CLK_TIM17:
            case FMKCPU_RCC_CLK_TIM2:
            case FMKCPU_RCC_CLK_TIM3:
            case FMKCPU_RCC_CLK_TIM4:
            case FMKCPU_RCC_CLK_TIM5:
            case FMKCPU_RCC_CLK_TIM6:
            case FMKCPU_RCC_CLK_TIM7:
            case FMKCPU_RCC_CLK_TIM8:
            case FMKCPU_RCC_CLK_UART4:
            case FMKCPU_RCC_CLK_UART5:
            case FMKCPU_RCC_CLK_UART7:
            case FMKCPU_RCC_CLK_UART8:
            case FMKCPU_RCC_CLK_USART1:
            case FMKCPU_RCC_CLK_USART2:
            case FMKCPU_RCC_CLK_USART3:
            case FMKCPU_RCC_CLK_USART6:
            case FMKCPU_RCC_CLK_USB1_OTG_HS:
            case FMKCPU_RCC_CLK_USB1_OTG_HS_ULPI:
            case FMKCPU_RCC_CLK_VREF:
            case FMKCPU_RCC_CLK_WWDG1:
            case FMKCPU_RCC_CLK_NB:
            default:
                Ret_e = RC_WARNING_NO_OPERATION;
                break;
            /* CAUTION : Automatic generated code section for Periph Clock Cfg: End */
        }
    }
    //---- call periph clock config with all configutaion ---//
    bspRet_e = HAL_RCCEx_PeriphCLKConfig(&periphClkCfg_s);
    if(bspRet_e != HAL_OK)
    {
        Ret_e = RC_ERROR_WRONG_RESULT;
    }
    
    //------ No Need To Transfer this return code ------//
    if(Ret_e == RC_WARNING_NO_OPERATION)
    {
        Ret_e = RC_OK;
    }
    

    return Ret_e;
}
#endif // FMKCPU_STM32_ECU_FAMILY_G4 | FMKCPU_STM32_ECU_FAMILY_H7

/* CAUTION : Automatic generated code section for Enable Clk Implementation: Start */
/**< Function to enable ADC12 rcc clock*/
void FMKCPU_Enable_ADC12_Clock(void) {__HAL_RCC_ADC12_CLK_ENABLE();}
/**< Function to enable ADC3 rcc clock*/
void FMKCPU_Enable_ADC3_Clock(void) {__HAL_RCC_ADC3_CLK_ENABLE();}
/**< Function to enable BDMA rcc clock*/
void FMKCPU_Enable_BDMA_Clock(void) {__HAL_RCC_BDMA_CLK_ENABLE();}
/**< Function to enable BKPRAM rcc clock*/
void FMKCPU_Enable_BKPRAM_Clock(void) {__HAL_RCC_BKPRAM_CLK_ENABLE();}
/**< Function to enable CEC rcc clock*/
void FMKCPU_Enable_CEC_Clock(void) {__HAL_RCC_CEC_CLK_ENABLE();}
/**< Function to enable COMP12 rcc clock*/
void FMKCPU_Enable_COMP12_Clock(void) {__HAL_RCC_COMP12_CLK_ENABLE();}
/**< Function to enable CRC rcc clock*/
void FMKCPU_Enable_CRC_Clock(void) {__HAL_RCC_CRC_CLK_ENABLE();}
/**< Function to enable CRS rcc clock*/
void FMKCPU_Enable_CRS_Clock(void) {__HAL_RCC_CRS_CLK_ENABLE();}
/**< Function to enable CRYP rcc clock*/
void FMKCPU_Enable_CRYP_Clock(void) {__HAL_RCC_CRYP_CLK_ENABLE();}
/**< Function to enable D2SRAM1 rcc clock*/
void FMKCPU_Enable_D2SRAM1_Clock(void) {__HAL_RCC_D2SRAM1_CLK_ENABLE();}
/**< Function to enable D2SRAM2 rcc clock*/
void FMKCPU_Enable_D2SRAM2_Clock(void) {__HAL_RCC_D2SRAM2_CLK_ENABLE();}
/**< Function to enable D2SRAM3 rcc clock*/
void FMKCPU_Enable_D2SRAM3_Clock(void) {__HAL_RCC_D2SRAM3_CLK_ENABLE();}
/**< Function to enable DAC12 rcc clock*/
void FMKCPU_Enable_DAC12_Clock(void) {__HAL_RCC_DAC12_CLK_ENABLE();}
/**< Function to enable DCMI rcc clock*/
void FMKCPU_Enable_DCMI_Clock(void) {__HAL_RCC_DCMI_CLK_ENABLE();}
/**< Function to enable DFSDM1 rcc clock*/
void FMKCPU_Enable_DFSDM1_Clock(void) {__HAL_RCC_DFSDM1_CLK_ENABLE();}
/**< Function to enable DMA1 rcc clock*/
void FMKCPU_Enable_DMA1_Clock(void) {__HAL_RCC_DMA1_CLK_ENABLE();}
/**< Function to enable DMA2 rcc clock*/
void FMKCPU_Enable_DMA2_Clock(void) {__HAL_RCC_DMA2_CLK_ENABLE();}
/**< Function to enable DMA2D rcc clock*/
void FMKCPU_Enable_DMA2D_Clock(void) {__HAL_RCC_DMA2D_CLK_ENABLE();}
/**< Function to enable ETH1MAC rcc clock*/
void FMKCPU_Enable_ETH1MAC_Clock(void) {__HAL_RCC_ETH1MAC_CLK_ENABLE();}
/**< Function to enable ETH1RX rcc clock*/
void FMKCPU_Enable_ETH1RX_Clock(void) {__HAL_RCC_ETH1RX_CLK_ENABLE();}
/**< Function to enable ETH1TX rcc clock*/
void FMKCPU_Enable_ETH1TX_Clock(void) {__HAL_RCC_ETH1TX_CLK_ENABLE();}
/**< Function to enable FDCAN rcc clock*/
void FMKCPU_Enable_FDCAN_Clock(void) {__HAL_RCC_FDCAN_CLK_ENABLE();}
/**< Function to enable FMC rcc clock*/
void FMKCPU_Enable_FMC_Clock(void) {__HAL_RCC_FMC_CLK_ENABLE();}
/**< Function to enable GPIOA rcc clock*/
void FMKCPU_Enable_GPIOA_Clock(void) {__HAL_RCC_GPIOA_CLK_ENABLE();}
/**< Function to enable GPIOB rcc clock*/
void FMKCPU_Enable_GPIOB_Clock(void) {__HAL_RCC_GPIOB_CLK_ENABLE();}
/**< Function to enable GPIOC rcc clock*/
void FMKCPU_Enable_GPIOC_Clock(void) {__HAL_RCC_GPIOC_CLK_ENABLE();}
/**< Function to enable GPIOD rcc clock*/
void FMKCPU_Enable_GPIOD_Clock(void) {__HAL_RCC_GPIOD_CLK_ENABLE();}
/**< Function to enable GPIOE rcc clock*/
void FMKCPU_Enable_GPIOE_Clock(void) {__HAL_RCC_GPIOE_CLK_ENABLE();}
/**< Function to enable GPIOF rcc clock*/
void FMKCPU_Enable_GPIOF_Clock(void) {__HAL_RCC_GPIOF_CLK_ENABLE();}
/**< Function to enable GPIOG rcc clock*/
void FMKCPU_Enable_GPIOG_Clock(void) {__HAL_RCC_GPIOG_CLK_ENABLE();}
/**< Function to enable GPIOH rcc clock*/
void FMKCPU_Enable_GPIOH_Clock(void) {__HAL_RCC_GPIOH_CLK_ENABLE();}
/**< Function to enable GPIOI rcc clock*/
void FMKCPU_Enable_GPIOI_Clock(void) {__HAL_RCC_GPIOI_CLK_ENABLE();}
/**< Function to enable GPIOJ rcc clock*/
void FMKCPU_Enable_GPIOJ_Clock(void) {__HAL_RCC_GPIOJ_CLK_ENABLE();}
/**< Function to enable GPIOK rcc clock*/
void FMKCPU_Enable_GPIOK_Clock(void) {__HAL_RCC_GPIOK_CLK_ENABLE();}
/**< Function to enable HASH rcc clock*/
void FMKCPU_Enable_HASH_Clock(void) {__HAL_RCC_HASH_CLK_ENABLE();}
/**< Function to enable HRTIM1 rcc clock*/
void FMKCPU_Enable_HRTIM1_Clock(void) {__HAL_RCC_HRTIM1_CLK_ENABLE();}
/**< Function to enable HSEM rcc clock*/
void FMKCPU_Enable_HSEM_Clock(void) {__HAL_RCC_HSEM_CLK_ENABLE();}
/**< Function to enable I2C1 rcc clock*/
void FMKCPU_Enable_I2C1_Clock(void) {__HAL_RCC_I2C1_CLK_ENABLE();}
/**< Function to enable I2C2 rcc clock*/
void FMKCPU_Enable_I2C2_Clock(void) {__HAL_RCC_I2C2_CLK_ENABLE();}
/**< Function to enable I2C3 rcc clock*/
void FMKCPU_Enable_I2C3_Clock(void) {__HAL_RCC_I2C3_CLK_ENABLE();}
/**< Function to enable I2C4 rcc clock*/
void FMKCPU_Enable_I2C4_Clock(void) {__HAL_RCC_I2C4_CLK_ENABLE();}
/**< Function to enable JPGDECEN rcc clock*/
void FMKCPU_Enable_JPGDECEN_Clock(void) {__HAL_RCC_JPGDECEN_CLK_ENABLE();}
/**< Function to enable LPTIM1 rcc clock*/
void FMKCPU_Enable_LPTIM1_Clock(void) {__HAL_RCC_LPTIM1_CLK_ENABLE();}
/**< Function to enable LPTIM2 rcc clock*/
void FMKCPU_Enable_LPTIM2_Clock(void) {__HAL_RCC_LPTIM2_CLK_ENABLE();}
/**< Function to enable LPTIM3 rcc clock*/
void FMKCPU_Enable_LPTIM3_Clock(void) {__HAL_RCC_LPTIM3_CLK_ENABLE();}
/**< Function to enable LPTIM4 rcc clock*/
void FMKCPU_Enable_LPTIM4_Clock(void) {__HAL_RCC_LPTIM4_CLK_ENABLE();}
/**< Function to enable LPTIM5 rcc clock*/
void FMKCPU_Enable_LPTIM5_Clock(void) {__HAL_RCC_LPTIM5_CLK_ENABLE();}
/**< Function to enable LPUART1 rcc clock*/
void FMKCPU_Enable_LPUART1_Clock(void) {__HAL_RCC_LPUART1_CLK_ENABLE();}
/**< Function to enable LTDC rcc clock*/
void FMKCPU_Enable_LTDC_Clock(void) {__HAL_RCC_LTDC_CLK_ENABLE();}
/**< Function to enable MDIOS rcc clock*/
void FMKCPU_Enable_MDIOS_Clock(void) {__HAL_RCC_MDIOS_CLK_ENABLE();}
/**< Function to enable MDMA rcc clock*/
void FMKCPU_Enable_MDMA_Clock(void) {__HAL_RCC_MDMA_CLK_ENABLE();}
/**< Function to enable OPAMP rcc clock*/
void FMKCPU_Enable_OPAMP_Clock(void) {__HAL_RCC_OPAMP_CLK_ENABLE();}
/**< Function to enable QSPI rcc clock*/
void FMKCPU_Enable_QSPI_Clock(void) {__HAL_RCC_QSPI_CLK_ENABLE();}
/**< Function to enable RNG rcc clock*/
void FMKCPU_Enable_RNG_Clock(void) {__HAL_RCC_RNG_CLK_ENABLE();}
/**< Function to enable RTC rcc clock*/
void FMKCPU_Enable_RTC_Clock(void) {__HAL_RCC_RTC_CLK_ENABLE();}
/**< Function to enable SAI1 rcc clock*/
void FMKCPU_Enable_SAI1_Clock(void) {__HAL_RCC_SAI1_CLK_ENABLE();}
/**< Function to enable SAI2 rcc clock*/
void FMKCPU_Enable_SAI2_Clock(void) {__HAL_RCC_SAI2_CLK_ENABLE();}
/**< Function to enable SAI3 rcc clock*/
void FMKCPU_Enable_SAI3_Clock(void) {__HAL_RCC_SAI3_CLK_ENABLE();}
/**< Function to enable SAI4 rcc clock*/
void FMKCPU_Enable_SAI4_Clock(void) {__HAL_RCC_SAI4_CLK_ENABLE();}
/**< Function to enable SDMMC1 rcc clock*/
void FMKCPU_Enable_SDMMC1_Clock(void) {__HAL_RCC_SDMMC1_CLK_ENABLE();}
/**< Function to enable SDMMC2 rcc clock*/
void FMKCPU_Enable_SDMMC2_Clock(void) {__HAL_RCC_SDMMC2_CLK_ENABLE();}
/**< Function to enable SPDIFRX rcc clock*/
void FMKCPU_Enable_SPDIFRX_Clock(void) {__HAL_RCC_SPDIFRX_CLK_ENABLE();}
/**< Function to enable SPI1 rcc clock*/
void FMKCPU_Enable_SPI1_Clock(void) {__HAL_RCC_SPI1_CLK_ENABLE();}
/**< Function to enable SPI2 rcc clock*/
void FMKCPU_Enable_SPI2_Clock(void) {__HAL_RCC_SPI2_CLK_ENABLE();}
/**< Function to enable SPI3 rcc clock*/
void FMKCPU_Enable_SPI3_Clock(void) {__HAL_RCC_SPI3_CLK_ENABLE();}
/**< Function to enable SPI4 rcc clock*/
void FMKCPU_Enable_SPI4_Clock(void) {__HAL_RCC_SPI4_CLK_ENABLE();}
/**< Function to enable SPI5 rcc clock*/
void FMKCPU_Enable_SPI5_Clock(void) {__HAL_RCC_SPI5_CLK_ENABLE();}
/**< Function to enable SPI6 rcc clock*/
void FMKCPU_Enable_SPI6_Clock(void) {__HAL_RCC_SPI6_CLK_ENABLE();}
/**< Function to enable SWPMI1 rcc clock*/
void FMKCPU_Enable_SWPMI1_Clock(void) {__HAL_RCC_SWPMI1_CLK_ENABLE();}
/**< Function to enable SYSCFG rcc clock*/
void FMKCPU_Enable_SYSCFG_Clock(void) {__HAL_RCC_SYSCFG_CLK_ENABLE();}
/**< Function to enable TIM1 rcc clock*/
void FMKCPU_Enable_TIM1_Clock(void) {__HAL_RCC_TIM1_CLK_ENABLE();}
/**< Function to enable TIM12 rcc clock*/
void FMKCPU_Enable_TIM12_Clock(void) {__HAL_RCC_TIM12_CLK_ENABLE();}
/**< Function to enable TIM13 rcc clock*/
void FMKCPU_Enable_TIM13_Clock(void) {__HAL_RCC_TIM13_CLK_ENABLE();}
/**< Function to enable TIM14 rcc clock*/
void FMKCPU_Enable_TIM14_Clock(void) {__HAL_RCC_TIM14_CLK_ENABLE();}
/**< Function to enable TIM15 rcc clock*/
void FMKCPU_Enable_TIM15_Clock(void) {__HAL_RCC_TIM15_CLK_ENABLE();}
/**< Function to enable TIM16 rcc clock*/
void FMKCPU_Enable_TIM16_Clock(void) {__HAL_RCC_TIM16_CLK_ENABLE();}
/**< Function to enable TIM17 rcc clock*/
void FMKCPU_Enable_TIM17_Clock(void) {__HAL_RCC_TIM17_CLK_ENABLE();}
/**< Function to enable TIM2 rcc clock*/
void FMKCPU_Enable_TIM2_Clock(void) {__HAL_RCC_TIM2_CLK_ENABLE();}
/**< Function to enable TIM3 rcc clock*/
void FMKCPU_Enable_TIM3_Clock(void) {__HAL_RCC_TIM3_CLK_ENABLE();}
/**< Function to enable TIM4 rcc clock*/
void FMKCPU_Enable_TIM4_Clock(void) {__HAL_RCC_TIM4_CLK_ENABLE();}
/**< Function to enable TIM5 rcc clock*/
void FMKCPU_Enable_TIM5_Clock(void) {__HAL_RCC_TIM5_CLK_ENABLE();}
/**< Function to enable TIM6 rcc clock*/
void FMKCPU_Enable_TIM6_Clock(void) {__HAL_RCC_TIM6_CLK_ENABLE();}
/**< Function to enable TIM7 rcc clock*/
void FMKCPU_Enable_TIM7_Clock(void) {__HAL_RCC_TIM7_CLK_ENABLE();}
/**< Function to enable TIM8 rcc clock*/
void FMKCPU_Enable_TIM8_Clock(void) {__HAL_RCC_TIM8_CLK_ENABLE();}
/**< Function to enable UART4 rcc clock*/
void FMKCPU_Enable_UART4_Clock(void) {__HAL_RCC_UART4_CLK_ENABLE();}
/**< Function to enable UART5 rcc clock*/
void FMKCPU_Enable_UART5_Clock(void) {__HAL_RCC_UART5_CLK_ENABLE();}
/**< Function to enable UART7 rcc clock*/
void FMKCPU_Enable_UART7_Clock(void) {__HAL_RCC_UART7_CLK_ENABLE();}
/**< Function to enable UART8 rcc clock*/
void FMKCPU_Enable_UART8_Clock(void) {__HAL_RCC_UART8_CLK_ENABLE();}
/**< Function to enable USART1 rcc clock*/
void FMKCPU_Enable_USART1_Clock(void) {__HAL_RCC_USART1_CLK_ENABLE();}
/**< Function to enable USART2 rcc clock*/
void FMKCPU_Enable_USART2_Clock(void) {__HAL_RCC_USART2_CLK_ENABLE();}
/**< Function to enable USART3 rcc clock*/
void FMKCPU_Enable_USART3_Clock(void) {__HAL_RCC_USART3_CLK_ENABLE();}
/**< Function to enable USART6 rcc clock*/
void FMKCPU_Enable_USART6_Clock(void) {__HAL_RCC_USART6_CLK_ENABLE();}
/**< Function to enable USB1_OTG_HS rcc clock*/
void FMKCPU_Enable_USB1_OTG_HS_Clock(void) {__HAL_RCC_USB1_OTG_HS_CLK_ENABLE();}
/**< Function to enable USB1_OTG_HS_ULPI rcc clock*/
void FMKCPU_Enable_USB1_OTG_HS_ULPI_Clock(void) {__HAL_RCC_USB1_OTG_HS_ULPI_CLK_ENABLE();}
/**< Function to enable VREF rcc clock*/
void FMKCPU_Enable_VREF_Clock(void) {__HAL_RCC_VREF_CLK_ENABLE();}
/**< Function to enable WWDG1 rcc clock*/
void FMKCPU_Enable_WWDG1_Clock(void) {__HAL_RCC_WWDG1_CLK_ENABLE();}
/* CAUTION : Automatic generated code section for Enable Clk Implementation: End */

/* CAUTION : Automatic generated code section for Disable Clk Implementation: Start */
/**< Function to disable ADC12 rcc clock*/
void FMKCPU_Disable_ADC12_Clock(void) {__HAL_RCC_ADC12_CLK_DISABLE();}
/**< Function to disable ADC3 rcc clock*/
void FMKCPU_Disable_ADC3_Clock(void) {__HAL_RCC_ADC3_CLK_DISABLE();}
/**< Function to disable BDMA rcc clock*/
void FMKCPU_Disable_BDMA_Clock(void) {__HAL_RCC_BDMA_CLK_DISABLE();}
/**< Function to disable BKPRAM rcc clock*/
void FMKCPU_Disable_BKPRAM_Clock(void) {__HAL_RCC_BKPRAM_CLK_DISABLE();}
/**< Function to disable CEC rcc clock*/
void FMKCPU_Disable_CEC_Clock(void) {__HAL_RCC_CEC_CLK_DISABLE();}
/**< Function to disable COMP12 rcc clock*/
void FMKCPU_Disable_COMP12_Clock(void) {__HAL_RCC_COMP12_CLK_DISABLE();}
/**< Function to disable CRC rcc clock*/
void FMKCPU_Disable_CRC_Clock(void) {__HAL_RCC_CRC_CLK_DISABLE();}
/**< Function to disable CRS rcc clock*/
void FMKCPU_Disable_CRS_Clock(void) {__HAL_RCC_CRS_CLK_DISABLE();}
/**< Function to disable CRYP rcc clock*/
void FMKCPU_Disable_CRYP_Clock(void) {__HAL_RCC_CRYP_CLK_DISABLE();}
/**< Function to disable D2SRAM1 rcc clock*/
void FMKCPU_Disable_D2SRAM1_Clock(void) {__HAL_RCC_D2SRAM1_CLK_DISABLE();}
/**< Function to disable D2SRAM2 rcc clock*/
void FMKCPU_Disable_D2SRAM2_Clock(void) {__HAL_RCC_D2SRAM2_CLK_DISABLE();}
/**< Function to disable D2SRAM3 rcc clock*/
void FMKCPU_Disable_D2SRAM3_Clock(void) {__HAL_RCC_D2SRAM3_CLK_DISABLE();}
/**< Function to disable DAC12 rcc clock*/
void FMKCPU_Disable_DAC12_Clock(void) {__HAL_RCC_DAC12_CLK_DISABLE();}
/**< Function to disable DCMI rcc clock*/
void FMKCPU_Disable_DCMI_Clock(void) {__HAL_RCC_DCMI_CLK_DISABLE();}
/**< Function to disable DFSDM1 rcc clock*/
void FMKCPU_Disable_DFSDM1_Clock(void) {__HAL_RCC_DFSDM1_CLK_DISABLE();}
/**< Function to disable DMA1 rcc clock*/
void FMKCPU_Disable_DMA1_Clock(void) {__HAL_RCC_DMA1_CLK_DISABLE();}
/**< Function to disable DMA2 rcc clock*/
void FMKCPU_Disable_DMA2_Clock(void) {__HAL_RCC_DMA2_CLK_DISABLE();}
/**< Function to disable DMA2D rcc clock*/
void FMKCPU_Disable_DMA2D_Clock(void) {__HAL_RCC_DMA2D_CLK_DISABLE();}
/**< Function to disable ETH1MAC rcc clock*/
void FMKCPU_Disable_ETH1MAC_Clock(void) {__HAL_RCC_ETH1MAC_CLK_DISABLE();}
/**< Function to disable ETH1RX rcc clock*/
void FMKCPU_Disable_ETH1RX_Clock(void) {__HAL_RCC_ETH1RX_CLK_DISABLE();}
/**< Function to disable ETH1TX rcc clock*/
void FMKCPU_Disable_ETH1TX_Clock(void) {__HAL_RCC_ETH1TX_CLK_DISABLE();}
/**< Function to disable FDCAN rcc clock*/
void FMKCPU_Disable_FDCAN_Clock(void) {__HAL_RCC_FDCAN_CLK_DISABLE();}
/**< Function to disable FMC rcc clock*/
void FMKCPU_Disable_FMC_Clock(void) {__HAL_RCC_FMC_CLK_DISABLE();}
/**< Function to disable GPIOA rcc clock*/
void FMKCPU_Disable_GPIOA_Clock(void) {__HAL_RCC_GPIOA_CLK_DISABLE();}
/**< Function to disable GPIOB rcc clock*/
void FMKCPU_Disable_GPIOB_Clock(void) {__HAL_RCC_GPIOB_CLK_DISABLE();}
/**< Function to disable GPIOC rcc clock*/
void FMKCPU_Disable_GPIOC_Clock(void) {__HAL_RCC_GPIOC_CLK_DISABLE();}
/**< Function to disable GPIOD rcc clock*/
void FMKCPU_Disable_GPIOD_Clock(void) {__HAL_RCC_GPIOD_CLK_DISABLE();}
/**< Function to disable GPIOE rcc clock*/
void FMKCPU_Disable_GPIOE_Clock(void) {__HAL_RCC_GPIOE_CLK_DISABLE();}
/**< Function to disable GPIOF rcc clock*/
void FMKCPU_Disable_GPIOF_Clock(void) {__HAL_RCC_GPIOF_CLK_DISABLE();}
/**< Function to disable GPIOG rcc clock*/
void FMKCPU_Disable_GPIOG_Clock(void) {__HAL_RCC_GPIOG_CLK_DISABLE();}
/**< Function to disable GPIOH rcc clock*/
void FMKCPU_Disable_GPIOH_Clock(void) {__HAL_RCC_GPIOH_CLK_DISABLE();}
/**< Function to disable GPIOI rcc clock*/
void FMKCPU_Disable_GPIOI_Clock(void) {__HAL_RCC_GPIOI_CLK_DISABLE();}
/**< Function to disable GPIOJ rcc clock*/
void FMKCPU_Disable_GPIOJ_Clock(void) {__HAL_RCC_GPIOJ_CLK_DISABLE();}
/**< Function to disable GPIOK rcc clock*/
void FMKCPU_Disable_GPIOK_Clock(void) {__HAL_RCC_GPIOK_CLK_DISABLE();}
/**< Function to disable HASH rcc clock*/
void FMKCPU_Disable_HASH_Clock(void) {__HAL_RCC_HASH_CLK_DISABLE();}
/**< Function to disable HRTIM1 rcc clock*/
void FMKCPU_Disable_HRTIM1_Clock(void) {__HAL_RCC_HRTIM1_CLK_DISABLE();}
/**< Function to disable HSEM rcc clock*/
void FMKCPU_Disable_HSEM_Clock(void) {__HAL_RCC_HSEM_CLK_DISABLE();}
/**< Function to disable I2C1 rcc clock*/
void FMKCPU_Disable_I2C1_Clock(void) {__HAL_RCC_I2C1_CLK_DISABLE();}
/**< Function to disable I2C2 rcc clock*/
void FMKCPU_Disable_I2C2_Clock(void) {__HAL_RCC_I2C2_CLK_DISABLE();}
/**< Function to disable I2C3 rcc clock*/
void FMKCPU_Disable_I2C3_Clock(void) {__HAL_RCC_I2C3_CLK_DISABLE();}
/**< Function to disable I2C4 rcc clock*/
void FMKCPU_Disable_I2C4_Clock(void) {__HAL_RCC_I2C4_CLK_DISABLE();}
/**< Function to disable JPGDECEN rcc clock*/
void FMKCPU_Disable_JPGDECEN_Clock(void) {__HAL_RCC_JPGDECEN_CLK_DISABLE();}
/**< Function to disable LPTIM1 rcc clock*/
void FMKCPU_Disable_LPTIM1_Clock(void) {__HAL_RCC_LPTIM1_CLK_DISABLE();}
/**< Function to disable LPTIM2 rcc clock*/
void FMKCPU_Disable_LPTIM2_Clock(void) {__HAL_RCC_LPTIM2_CLK_DISABLE();}
/**< Function to disable LPTIM3 rcc clock*/
void FMKCPU_Disable_LPTIM3_Clock(void) {__HAL_RCC_LPTIM3_CLK_DISABLE();}
/**< Function to disable LPTIM4 rcc clock*/
void FMKCPU_Disable_LPTIM4_Clock(void) {__HAL_RCC_LPTIM4_CLK_DISABLE();}
/**< Function to disable LPTIM5 rcc clock*/
void FMKCPU_Disable_LPTIM5_Clock(void) {__HAL_RCC_LPTIM5_CLK_DISABLE();}
/**< Function to disable LPUART1 rcc clock*/
void FMKCPU_Disable_LPUART1_Clock(void) {__HAL_RCC_LPUART1_CLK_DISABLE();}
/**< Function to disable LTDC rcc clock*/
void FMKCPU_Disable_LTDC_Clock(void) {__HAL_RCC_LTDC_CLK_DISABLE();}
/**< Function to disable MDIOS rcc clock*/
void FMKCPU_Disable_MDIOS_Clock(void) {__HAL_RCC_MDIOS_CLK_DISABLE();}
/**< Function to disable MDMA rcc clock*/
void FMKCPU_Disable_MDMA_Clock(void) {__HAL_RCC_MDMA_CLK_DISABLE();}
/**< Function to disable OPAMP rcc clock*/
void FMKCPU_Disable_OPAMP_Clock(void) {__HAL_RCC_OPAMP_CLK_DISABLE();}
/**< Function to disable QSPI rcc clock*/
void FMKCPU_Disable_QSPI_Clock(void) {__HAL_RCC_QSPI_CLK_DISABLE();}
/**< Function to disable RNG rcc clock*/
void FMKCPU_Disable_RNG_Clock(void) {__HAL_RCC_RNG_CLK_DISABLE();}
/**< Function to disable RTC rcc clock*/
void FMKCPU_Disable_RTC_Clock(void) {__HAL_RCC_RTC_CLK_DISABLE();}
/**< Function to disable SAI1 rcc clock*/
void FMKCPU_Disable_SAI1_Clock(void) {__HAL_RCC_SAI1_CLK_DISABLE();}
/**< Function to disable SAI2 rcc clock*/
void FMKCPU_Disable_SAI2_Clock(void) {__HAL_RCC_SAI2_CLK_DISABLE();}
/**< Function to disable SAI3 rcc clock*/
void FMKCPU_Disable_SAI3_Clock(void) {__HAL_RCC_SAI3_CLK_DISABLE();}
/**< Function to disable SAI4 rcc clock*/
void FMKCPU_Disable_SAI4_Clock(void) {__HAL_RCC_SAI4_CLK_DISABLE();}
/**< Function to disable SDMMC1 rcc clock*/
void FMKCPU_Disable_SDMMC1_Clock(void) {__HAL_RCC_SDMMC1_CLK_DISABLE();}
/**< Function to disable SDMMC2 rcc clock*/
void FMKCPU_Disable_SDMMC2_Clock(void) {__HAL_RCC_SDMMC2_CLK_DISABLE();}
/**< Function to disable SPDIFRX rcc clock*/
void FMKCPU_Disable_SPDIFRX_Clock(void) {__HAL_RCC_SPDIFRX_CLK_DISABLE();}
/**< Function to disable SPI1 rcc clock*/
void FMKCPU_Disable_SPI1_Clock(void) {__HAL_RCC_SPI1_CLK_DISABLE();}
/**< Function to disable SPI2 rcc clock*/
void FMKCPU_Disable_SPI2_Clock(void) {__HAL_RCC_SPI2_CLK_DISABLE();}
/**< Function to disable SPI3 rcc clock*/
void FMKCPU_Disable_SPI3_Clock(void) {__HAL_RCC_SPI3_CLK_DISABLE();}
/**< Function to disable SPI4 rcc clock*/
void FMKCPU_Disable_SPI4_Clock(void) {__HAL_RCC_SPI4_CLK_DISABLE();}
/**< Function to disable SPI5 rcc clock*/
void FMKCPU_Disable_SPI5_Clock(void) {__HAL_RCC_SPI5_CLK_DISABLE();}
/**< Function to disable SPI6 rcc clock*/
void FMKCPU_Disable_SPI6_Clock(void) {__HAL_RCC_SPI6_CLK_DISABLE();}
/**< Function to disable SWPMI1 rcc clock*/
void FMKCPU_Disable_SWPMI1_Clock(void) {__HAL_RCC_SWPMI1_CLK_DISABLE();}
/**< Function to disable SYSCFG rcc clock*/
void FMKCPU_Disable_SYSCFG_Clock(void) {__HAL_RCC_SYSCFG_CLK_DISABLE();}
/**< Function to disable TIM1 rcc clock*/
void FMKCPU_Disable_TIM1_Clock(void) {__HAL_RCC_TIM1_CLK_DISABLE();}
/**< Function to disable TIM12 rcc clock*/
void FMKCPU_Disable_TIM12_Clock(void) {__HAL_RCC_TIM12_CLK_DISABLE();}
/**< Function to disable TIM13 rcc clock*/
void FMKCPU_Disable_TIM13_Clock(void) {__HAL_RCC_TIM13_CLK_DISABLE();}
/**< Function to disable TIM14 rcc clock*/
void FMKCPU_Disable_TIM14_Clock(void) {__HAL_RCC_TIM14_CLK_DISABLE();}
/**< Function to disable TIM15 rcc clock*/
void FMKCPU_Disable_TIM15_Clock(void) {__HAL_RCC_TIM15_CLK_DISABLE();}
/**< Function to disable TIM16 rcc clock*/
void FMKCPU_Disable_TIM16_Clock(void) {__HAL_RCC_TIM16_CLK_DISABLE();}
/**< Function to disable TIM17 rcc clock*/
void FMKCPU_Disable_TIM17_Clock(void) {__HAL_RCC_TIM17_CLK_DISABLE();}
/**< Function to disable TIM2 rcc clock*/
void FMKCPU_Disable_TIM2_Clock(void) {__HAL_RCC_TIM2_CLK_DISABLE();}
/**< Function to disable TIM3 rcc clock*/
void FMKCPU_Disable_TIM3_Clock(void) {__HAL_RCC_TIM3_CLK_DISABLE();}
/**< Function to disable TIM4 rcc clock*/
void FMKCPU_Disable_TIM4_Clock(void) {__HAL_RCC_TIM4_CLK_DISABLE();}
/**< Function to disable TIM5 rcc clock*/
void FMKCPU_Disable_TIM5_Clock(void) {__HAL_RCC_TIM5_CLK_DISABLE();}
/**< Function to disable TIM6 rcc clock*/
void FMKCPU_Disable_TIM6_Clock(void) {__HAL_RCC_TIM6_CLK_DISABLE();}
/**< Function to disable TIM7 rcc clock*/
void FMKCPU_Disable_TIM7_Clock(void) {__HAL_RCC_TIM7_CLK_DISABLE();}
/**< Function to disable TIM8 rcc clock*/
void FMKCPU_Disable_TIM8_Clock(void) {__HAL_RCC_TIM8_CLK_DISABLE();}
/**< Function to disable UART4 rcc clock*/
void FMKCPU_Disable_UART4_Clock(void) {__HAL_RCC_UART4_CLK_DISABLE();}
/**< Function to disable UART5 rcc clock*/
void FMKCPU_Disable_UART5_Clock(void) {__HAL_RCC_UART5_CLK_DISABLE();}
/**< Function to disable UART7 rcc clock*/
void FMKCPU_Disable_UART7_Clock(void) {__HAL_RCC_UART7_CLK_DISABLE();}
/**< Function to disable UART8 rcc clock*/
void FMKCPU_Disable_UART8_Clock(void) {__HAL_RCC_UART8_CLK_DISABLE();}
/**< Function to disable USART1 rcc clock*/
void FMKCPU_Disable_USART1_Clock(void) {__HAL_RCC_USART1_CLK_DISABLE();}
/**< Function to disable USART2 rcc clock*/
void FMKCPU_Disable_USART2_Clock(void) {__HAL_RCC_USART2_CLK_DISABLE();}
/**< Function to disable USART3 rcc clock*/
void FMKCPU_Disable_USART3_Clock(void) {__HAL_RCC_USART3_CLK_DISABLE();}
/**< Function to disable USART6 rcc clock*/
void FMKCPU_Disable_USART6_Clock(void) {__HAL_RCC_USART6_CLK_DISABLE();}
/**< Function to disable USB1_OTG_HS rcc clock*/
void FMKCPU_Disable_USB1_OTG_HS_Clock(void) {__HAL_RCC_USB1_OTG_HS_CLK_DISABLE();}
/**< Function to disable USB1_OTG_HS_ULPI rcc clock*/
void FMKCPU_Disable_USB1_OTG_HS_ULPI_Clock(void) {__HAL_RCC_USB1_OTG_HS_ULPI_CLK_DISABLE();}
/**< Function to disable VREF rcc clock*/
void FMKCPU_Disable_VREF_Clock(void) {__HAL_RCC_VREF_CLK_DISABLE();}
/**< Function to disable WWDG1 rcc clock*/
void FMKCPU_Disable_WWDG1_Clock(void) {__HAL_RCC_WWDG1_CLK_DISABLE();}
/* CAUTION : Automatic generated code section for Disable Clk Implementation: End */


//********************************************************************************
//                      Local functions - Implementation
//********************************************************************************
           
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
