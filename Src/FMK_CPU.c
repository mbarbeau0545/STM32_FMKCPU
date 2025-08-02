/**
 * @file        FMK_CPU.c
 * @brief       Framework for Unit Processing Control.
 * @note        TemplateDetailsDescription.\n
 *
 * @author      mba
 * @date        25/08/2024
 * @version     1.0
 */

// ********************************************************************
// *                      Includes
// ********************************************************************
#include "./FMK_CPU.h"
#include "FMK_CFG/FMKCFG_ConfigFiles/FMKCPU_ConfigPrivate.h"

#include "Constant.h"
#include "APP_CTRL/APP_SYS/Src/APP_SYS.h"
#include "3_APP/APP_CTRL/APP_SDM/Src/APP_SDM.h"
#include "Library/SafeMem/SafeMem.h"
// ********************************************************************
// *                      Defines
// ********************************************************************

// ********************************************************************
// *                      Types
// ********************************************************************
// ********************************************************************
// *                      Types
// ********************************************************************
//-----------------------------ENUM TYPES-----------------------------//
typedef enum 
{
    FMKCPU_DMA_ERRSTATE_OK = 0,                  /**< No error detected */
    FMKCPU_DMA_ERRSTATE_TRANSFER_COMPLETE,       /**< THe transfer is completed with an error */
    FMKCPU_DMA_ERRSTATE_TRANSFER_ERROR,          /**< THe transfer is incomplete with an error */
    FMKCPU_DMA_ERRSTATE_FIFO,                    /**< FIFO error, over/under debit from FIFO to DMA */
    FMKCPU_DMA_ERRSTATE_XFER,                    /**< Abort request with Xfer on going */
    FMKCPU_DMA_ERRSTATE_NOT_SUPPORTED,           /**< Not supported mode */
    FMKCPU_DMA_ERRSTATE_DIRECT_MODE,             /**< An error with direct mode DMA has been detected*/
    FMKCPU_DMA_ERRSTATE_SYNC,                    /**< DMAMUX Sync overrun */
    FMKCPU_DMA_ERRSTATE_REQGEN,                  /**< request generator vverrun */
    FMKCPU_DMA_ERRSTATE_INVALID_CHANNEL,         /**< DMA cannal invalid */
    FMKCPU_DMA_ERRSTATE_CONFIGURATION,           /**< A configuration error has been detected */
    FMKCPU_DMA_ERRSTATE_PRIORITY,                /**< Priority DMA has not been respected */
    FMKCPU_DMA_ERRSTATE_MEM_ALLOCATION,          /**< Error allocation memory (FIFO not allowed) */
    FMKCPU_DMA_ERRSTATE_TIMEOUT                  /**< Timeout delay (transfer has take too many time)*/
} t_eFMKCPU_DmaChnlErr;
//-----------------------------TYPEDEF TYPES---------------------------//
typedef struct
{
    DMA_HandleTypeDef bspDma_s;            /**< @ref  DMA_HandleTypeDef*/
    t_eFMKCPU_IRQNType c_IRQNType_e;                   /**< NVIC channel interruption config*/
    t_eFMKCPU_DmaChnlErr chnlErr_e;         /**< @ref t_eFMKCPU_DmaChnlErr*/
    t_bool isChnlConfigured_b;
    t_bool ErrorDetected_b;
} t_sFMKCPU_DmaChnlInfo;

typedef struct 
{
    t_sFMKCPU_DmaChnlInfo channel_as[FMKCPU_DMA_CHANNEL_NB];        /**< @ref  t_sFMKCPU_DmaChnlInfo*/
    t_eFMKCPU_ClockPort c_clock_e;                              /**< constant to store the clock for each ADC */                                         /**< Flag channel is configured */
} t_sFMKCPU_DmaInfo;

/* CAUTION : Automatic generated code section for Enum: Start */

/* CAUTION : Automatic generated code section for Enum: End */
/* CAUTION : Automatic generated code section for Structure: Start */

/* CAUTION : Automatic generated code section for Structure: End */


// ********************************************************************
// *                      Prototypes
// ********************************************************************

// ********************************************************************
// *                      Variables
// ********************************************************************
t_sFMKCPU_DmaInfo g_DmaInfo_as[FMKCPU_DMA_CTRL_NB];
t_eFMKCPU_ClockPortOpe g_DmaMuxState_ae[FMKCPU_DMA_MUX_NB];
t_eFMKCPU_ClockPortOpe g_DmaCtrlState_ae[FMKCPU_DMA_CTRL_NB];

static t_eCyclicModState g_FmkCpu_ModState_e = STATE_CYCLIC_CFG;

WWDG_HandleTypeDef g_wwdgInfos_s = {0};

t_uint8 g_SysClockValue_ua8[FMKCPU_SYS_CLOCK_NB];

t_bool g_IsSysClkInit_b = (t_bool)False;

//********************************************************************************
//                      Local functions - Prototypes
//********************************************************************************
/**
 *
 *	@brief      Perform all cyclic operation
 *
 *  @retval RC_OK                             @ref RC_OK
 *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
 *  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
 */
static t_eReturnCode s_FMKCPU_Operational(void);


/**
 *
 *	@brief      Perform Diagnostic on Timer and channels
 *  @note       If a error is detected on Timer, every channel used from this timer 
 *              inherit the error.\n
 * 
 *  @retval RC_OK                             @ref RC_OK
 *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
 *  @retval RC_ERROR_WRONG_STATE              @ref RC_ERROR_WRONG_STATE

 */
//static t_eReturnCode s_FMKCPU_PerformDiagnostic(void);
/**
 *
 *	@brief      Function to get the bsp NVIC priority init
 *
 *	@param[in]  f_priority_e              : enum value for the priority, value from @ref t_eFMKCPU_NVICPriority
 *	@param[in]  BspNVICPriority_pu32      : storage for NVIC priority.\n
 *
 *  @retval RC_OK                             @ref RC_OK
 *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
 *  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
 *  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
 *
 */
static t_eReturnCode s_FMKCPU_Get_BspNVICPriority(t_eFMKCPU_NVICPriority f_priority_e, t_uint32 *BspNVICPriority_pu32);
/**
*
*	@brief      Function to get the bsp dma channel
*
*	@param[in]  f_channel_e              : enum value for the channel, value from @ref t_eFMKCPU_InterruptChnl
*	@param[in]  f_bspChnl_pu32           : storage for bsp channel.\n
*
*  @retval RC_OK                             @ref RC_OK
*  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
*  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
*  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
*
*/
static t_eReturnCode s_FMKCPU_Set_DmaBspCfg(t_eFMKCPU_DmaRqst f_RqstType_e,
                                            t_eFMKCPU_DmaType f_Type_e,
                                            DMA_HandleTypeDef * f_bspDma_s,
                                            t_eFMKCPU_DmaTransferPriority f_dmaPrio_e,
                                            t_uFMKCPU_DmaHandleType * f_modHandle_pu);

/**
*
*	@brief      Link Dma Depending on the Request Type
*
*	@param[in]  f_channel_e              : enum value for the channel, value from @ref t_eFMKCPU_InterruptChnl
*	@param[in]  f_bspChnl_pu32           : storage for bsp channel.\n
*
*  @retval RC_OK                             @ref RC_OK
*  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
*  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
*  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
*
*/
static t_eReturnCode s_FMKCPU_SetDmaHwInit(t_eFMKCPU_DmaController f_dmaCtrl_e);

/**
*
*	@brief      Link Dma Depending on the Request Type
*
*	@param[in]  f_channel_e              : enum value for the channel, value from @ref t_eFMKCPU_InterruptChnl
*	@param[in]  f_bspChnl_pu32           : storage for bsp channel.\n
*
*  @retval RC_OK                             @ref RC_OK
*  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
*  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
*  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
*
*/
static t_eReturnCode s_FMKCPU_LinkDma(  t_eFMKCPU_DmaType f_DmaType_e,
                                        DMA_HandleTypeDef * f_bspDma_s,
                                        t_uFMKCPU_DmaHandleType * f_modHandle_pu);

/**
*
*	@brief      Function to get the bsp dma priority
*
*	@param[in]  f_channel_e              : enum value for the channel, value from @ref t_eFMKCPU_InterruptChnl
*	@param[in]  f_bspPriority_pu32       : storage for bsp prioirty.\n
*
*  @retval RC_OK                             @ref RC_OK
*  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
*  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
*  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
*
*/
static t_eReturnCode s_FMKCPU_Get_DmaBspPriority(   t_eFMKCPU_DmaTransferPriority f_priority_e, 
                                                    t_uint32 * f_bspPriority_pu32);
/**
*
*	@brief      Function to get the bsp dma priority
*
*	@param[in]  f_channel_e              : enum value for the channel, value from @ref t_eFMKCPU_InterruptChnl
*	@param[in]  f_bspPriority_pu32       : storage for bsp prioirty.\n
*
*  @retval RC_OK                             @ref RC_OK
*  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
*  @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
*  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
*
*/
static t_eReturnCode s_FMKCPU_DmaPerformDiagnostic( t_eFMKCPU_DmaController f_dmaCtrl_e, 
                                                    t_eFMKCPU_DmaChnl f_dmaChnl_e,
                                                    t_uint32  f_bspError_u32);
//****************************************************************************
//                      Public functions - Implementation
//********************************************************************************
t_eReturnCode FMKCPU_Init(void)
{
    t_uint8 idxDma_u8;
    t_uint8 idxChnl_u8;
    t_uint8 idxDmaMux_u8;

    //--------- Loop on every Dma ---------//
    for(idxDma_u8 = (t_uint8)0 ; idxDma_u8 < FMKCPU_DMA_CTRL_NB ; idxDma_u8++)
    {
        g_DmaInfo_as[idxDma_u8].c_clock_e = c_FmkCpu_DmaCfg_as[idxDma_u8].c_clock_e;
        //--------- Loop on every Channel ---------//
        for(idxChnl_u8 = (t_uint8)0 ; idxChnl_u8 < FMKCPU_DMA_CHANNEL_NB ; idxChnl_u8++)
        {
            g_DmaInfo_as[idxDma_u8].channel_as[idxChnl_u8].c_IRQNType_e =
                c_FmkCpu_DmaCfg_as[idxDma_u8].chnlCfg_as[idxChnl_u8].c_IRQNType_e;
            g_DmaInfo_as[idxDma_u8].channel_as[idxChnl_u8].bspDma_s.Instance =
                (DMA_Channel_TypeDef *)c_FmkCpu_DmaCfg_as[idxDma_u8].chnlCfg_as[idxChnl_u8].Instance;
            g_DmaInfo_as[idxDma_u8].channel_as[idxChnl_u8].isChnlConfigured_b = (t_bool)False;
            g_DmaInfo_as[idxDma_u8].channel_as[idxChnl_u8].chnlErr_e = FMKCPU_DMA_ERRSTATE_OK;
            g_DmaInfo_as[idxDma_u8].channel_as[idxChnl_u8].ErrorDetected_b = (t_bool)FALSE;
        }

        g_DmaCtrlState_ae[idxDma_u8] = FMKCPU_CLOCKPORT_OPE_DISABLE;
    }

    //--------- Loop on every Dma Mux ---------//
    for(idxDmaMux_u8 = (t_uint8)0 ; idxDmaMux_u8 < FMKCPU_DMA_MUX_NB ; idxDmaMux_u8++)
    {
        g_DmaMuxState_ae[idxDmaMux_u8] = FMKCPU_CLOCKPORT_OPE_DISABLE;
    }

    return RC_OK;
}
/*********************************
 * FMKCPU_Cyclic
 *********************************/
t_eReturnCode FMKCPU_Cyclic(void)
{
    t_eReturnCode Ret_e = RC_OK;

    switch (g_FmkCpu_ModState_e)
    {
        case STATE_CYCLIC_CFG:
        {
            g_FmkCpu_ModState_e = STATE_CYCLIC_WAITING;
            break;
        }
        case STATE_CYCLIC_WAITING:
        {
            // nothing to do, just wait all module are Ope
            break;
        }
        case STATE_CYCLIC_PREOPE:
        {
            g_FmkCpu_ModState_e = STATE_CYCLIC_OPE;
            break; 
        }
        case STATE_CYCLIC_OPE:
        {
            Ret_e = s_FMKCPU_Operational();
            if(Ret_e < RC_OK)
            {
                g_FmkCpu_ModState_e = STATE_CYCLIC_ERROR;
            }
            break;
        }
        case STATE_CYCLIC_ERROR:
        {
            break;
        }
        
        case STATE_CYCLIC_BUSY:
        default:
            Ret_e = RC_OK;
            break;
    }
    return Ret_e;
}

/*********************************
 * FMKCPU_GetState
 *********************************/
t_eReturnCode FMKCPU_GetState(t_eCyclicModState *f_State_pe)
{
    t_eReturnCode Ret_e = RC_OK;

    if(f_State_pe == (t_eCyclicModState *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
    }
    if(Ret_e == RC_OK)
    {
        *f_State_pe = g_FmkCpu_ModState_e;
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_SetState
 *********************************/
t_eReturnCode FMKCPU_SetState(t_eCyclicModState f_State_e)
{

    g_FmkCpu_ModState_e = f_State_e;

    return RC_OK;
}

/*********************************
 * FMKCPU_Set_Delay
 *********************************/
void FMKCPU_Set_Delay(t_uint32 f_delayms_u32) 
{
    t_uint32 startTime_u32 = (t_uint32)0;
    t_uint32 currentTime_u32 = (t_uint32)0;
    t_uint32 elapsedTime_u32 = (t_uint32)0;
    t_uint32 timeout_u32 = 1000;  // Timeout de 1000ms (1 seconde), ajustable selon vos besoins

    // Récupérer le tick initial
    FMKCPU_GetTick(&startTime_u32);

    // Si la valeur de startTime est 0, il y a un problème avec l'initialisation du tick
    if (startTime_u32 == (t_uint32)0)
    {
        return;  // Sortir immédiatement si HAL_GetTick() retourne 0
    }

    while (elapsedTime_u32 < f_delayms_u32)
    {
        // Vérifier si on atteint le timeout
        if (elapsedTime_u32 > timeout_u32)
        {
            // Timeout atteint, sortir de la fonction
            return;
        }

        // Récupérer le tick actuel
        FMKCPU_GetTick(&currentTime_u32);

        // Calcul de la différence en tenant compte de l'overflow
        if (currentTime_u32 >= startTime_u32)
        {
            elapsedTime_u32 = currentTime_u32 - startTime_u32;
        }
        else
        {
            // Gestion de l'overflow
            elapsedTime_u32 = (0xFFFFFFFF - startTime_u32) + currentTime_u32;
        }

        // Appeler une fonction d'arrière-plan ou mettre en veille pour économiser du CPU
        __NOP(); // No-operation (placeholder pour ne pas surcharger la CPU)
    }

    return;
}


/*********************************
 * FMKCPU_GetTick
 *********************************/
void FMKCPU_GetTick(t_uint32 * f_tickms_pu32)
{
    t_eReturnCode Ret_e = RC_OK;

    if( f_tickms_pu32 == (t_uint32 *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
    }
    if(Ret_e == RC_OK)
    {
        *f_tickms_pu32 = HAL_GetTick();
    }
    else 
    {
        *f_tickms_pu32 = (t_uint32)0;
    }
    return;
}

/*********************************
 * FMKCPU_Set_SysClockCfg
 *********************************/
t_eReturnCode FMKCPU_Set_SysClockCfg(t_eFMKCPU_CoreClockSpeed f_SystemCoreFreq_e)
{
    t_eReturnCode Ret_e = RC_OK;
    HAL_StatusTypeDef  bspRet_e = HAL_OK;
    
    RCC_OscInitTypeDef RCC_OscInitStruct = {0};
    RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
    t_uint32 bspSysClkFreqHz_u32;
    t_uint32 SysClkFreqHz_u32;
    t_sFMKCPU_SysOscCfg * bspOscCfg_ps;


    if(f_SystemCoreFreq_e >= FMKCPU_CORE_CLOCK_SPEED_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if(Ret_e == RC_OK)
    {
        bspOscCfg_ps = (t_sFMKCPU_SysOscCfg *)&c_FmkCpu_SysOscCfg_as[f_SystemCoreFreq_e];

#ifdef FMKCPU_STM32_ECU_FAMILY_G

        RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;               // 16 MHz
        RCC_OscInitStruct.HSIState = RCC_HSI_ON;
        RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
        RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;                             // use divider and stuff
        RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;                     // use HSI as PLL source clock
        RCC_OscInitStruct.PLL.PLLM = bspOscCfg_ps->PLLM_Divider_u32;             // Divided the HSI clock sources
        RCC_OscInitStruct.PLL.PLLN = bspOscCfg_ps->PPLN_Multplier_u32;           // Multiplied the HSI clock sources
        RCC_OscInitStruct.PLL.PLLP = bspOscCfg_ps->PLLP_Divider_u32;             // Divided the HSI clock sources -> that gives us PPLP clock source    
        RCC_OscInitStruct.PLL.PLLQ = bspOscCfg_ps->PPLQ_Divider_u32;             // Divided the HSI clock sources -> that gives us PPLQ clock source    
        RCC_OscInitStruct.PLL.PLLR = bspOscCfg_ps->PLLR_Divider_u32;             // Divided the HSI clock sources -> that gives us PPLCLK (SYSCLK) clock sources

        bspRet_e = HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1);
        
#elif defined FMKCPU_STM32_ECU_FAMILY_F

        RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
        RCC_OscInitStruct.HSIState = RCC_HSI_ON;
        RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
        RCC_OscInitStruct.PLL.PLLState = RCC_PLL_NONE;

#else 
    #error("Unknwon Stm32 Family")
#endif


        RCC_ClkInitStruct.ClockType      = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                                            |RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;

        RCC_ClkInitStruct.SYSCLKSource   = RCC_SYSCLKSOURCE_PLLCLK; 
        RCC_ClkInitStruct.AHBCLKDivider  = bspOscCfg_ps->AHB_Divider;
        RCC_ClkInitStruct.APB1CLKDivider = bspOscCfg_ps->APB1_Divider_u32;
        RCC_ClkInitStruct.APB2CLKDivider = bspOscCfg_ps->APB2_Divider_u32;

        if(bspRet_e == HAL_OK)
        bspRet_e = HAL_RCC_OscConfig(&RCC_OscInitStruct);
        if(bspRet_e == HAL_OK)
        {
            bspRet_e = HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2);
        }
        if(bspRet_e != HAL_OK)
        {
            g_FmkCpu_ModState_e = STATE_CYCLIC_ERROR;
            Ret_e = RC_ERROR_WRONG_RESULT;
            ASSERT((t_uint16)Ret_e);
        }
        else 
        {
            Ret_e = SafeMem_memcpy(&g_SysClockValue_ua8, &c_FmkCpu_CoreClkValue_ua8[f_SystemCoreFreq_e], (t_uint16)(sizeof(t_uint8) * FMKCPU_SYS_CLOCK_NB));
            if(Ret_e == RC_OK)
            {
                //------Get the system core frequency set by the bsp------//
                bspSysClkFreqHz_u32 = HAL_RCC_GetSysClockFreq();
                //------Get the system core frequency wanted by user------//
                SysClkFreqHz_u32 = (t_uint32)g_SysClockValue_ua8[FMKCPU_SYS_CLOCK_SYSTEM];
                //------Compare both value------//
                if(bspSysClkFreqHz_u32 != (t_uint32)(SysClkFreqHz_u32 * CST_MHZ_TO_HZ))
                {
                    Ret_e = RC_ERROR_WRONG_RESULT;
                    ASSERT((t_uint16)Ret_e);
                }
                else 
                {
                    g_IsSysClkInit_b = (t_bool)True;
                }
            }
        }
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_Set_SysClockCfg
 *********************************/
t_eReturnCode FMKCPU_Set_HardwareInit(void)
{
    t_eReturnCode Ret_e = RC_OK;
    HAL_StatusTypeDef bspRet_e = HAL_OK;

    bspRet_e = HAL_Init();
    if(bspRet_e == HAL_OK)
    {
        bspRet_e = HAL_InitTick(0x00); // High Priority
    }
    if(bspRet_e != HAL_OK)
    {
        Ret_e = RC_ERROR_WRONG_RESULT;
        ASSERT((t_uint16)Ret_e);
    }

#ifdef FMKCPU_STM32_ECU_FAMILY_G
    
    if(Ret_e == RC_OK)
    {
        Ret_e = FMKCPU_Set_HwClock(FMKCPU_RCC_CLK_SYSCFG, FMKCPU_CLOCKPORT_OPE_ENABLE);
    }
    if(Ret_e == RC_OK)
    {
        Ret_e = FMKCPU_Set_HwClock(FMKCPU_RCC_CLK_PWR, FMKCPU_CLOCKPORT_OPE_ENABLE);
    }
    if(Ret_e == RC_OK)
    {
        HAL_PWREx_DisableUCPDDeadBattery();
    }
#endif

    if(Ret_e != RC_OK)
    {
        g_FmkCpu_ModState_e = STATE_CYCLIC_ERROR;
        ASSERT((t_uint16)Ret_e);
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_Set_NVICState
 *********************************/
t_eReturnCode FMKCPU_Set_NVICState(t_eFMKCPU_IRQNType f_IRQN_e, t_eFMKCPU_NVIC_Ope f_OpeState_e)
{
    t_eReturnCode Ret_e = RC_OK;
    t_uint32 BspPriority_u32 = 0;
    IRQn_Type bspIRQN_e;

    if (f_IRQN_e > (t_eFMKCPU_IRQNType)FMKCPU_NVIC_NB || f_OpeState_e >= FMKCPU_NVIC_OPE_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if (Ret_e == RC_OK)
    {
        Ret_e = FMKCPU_Get_BspIRQNType(f_IRQN_e, &bspIRQN_e);
    }
    if(Ret_e == RC_OK)
    {
        switch (f_OpeState_e)
        {
            case FMKCPU_NVIC_OPE_ENABLE:
            { // Get the bspPriority using t_eFMKCPU_NVICPriority
                Ret_e = s_FMKCPU_Get_BspNVICPriority(c_FMKCPU_IRQNPriority_ae[f_IRQN_e], &BspPriority_u32);
                if (Ret_e == RC_OK)
                {
                    HAL_NVIC_SetPriority((IRQn_Type)bspIRQN_e, BspPriority_u32, 0);
                    HAL_NVIC_EnableIRQ((IRQn_Type)bspIRQN_e);
                }
                break;
            }

            case FMKCPU_NVIC_OPE_DISABLE:
            {
                HAL_NVIC_DisableIRQ((IRQn_Type)f_IRQN_e);
                break;
            }
            case FMKCPU_NVIC_OPE_NB:
            default:
                Ret_e = RC_ERROR_NOT_SUPPORTED;
                break;
        }
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_Set_HwClock
 *********************************/
t_eReturnCode FMKCPU_Set_HwClock(t_eFMKCPU_ClockPort f_clkPort_e,
                                  t_eFMKCPU_ClockPortOpe f_OpeState_e)
{
    t_eReturnCode Ret_e = RC_OK;

    if ((f_clkPort_e >= FMKCPU_RCC_CLK_NB) 
    ||  (f_OpeState_e >= FMKCPU_CLOCKPORT_OPE_NB))
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if (Ret_e == RC_OK)
    {
        switch (f_OpeState_e)
        {
        case FMKCPU_CLOCKPORT_OPE_ENABLE:
        {
#ifdef FMKCPU_STM32_ECU_FAMILY_G
            //------------------- Set Peripheral Clock config if needed----------------//
            Ret_e = FMKCPU_SetPeriphClockCfg(f_clkPort_e);
#endif
            if(Ret_e == RC_OK)
            {
                if (c_FMKCPU_ClkFunctions_apcb[f_clkPort_e].EnableClk_pcb != (t_cbFMKCPU_ClockDisable *)NULL_FUNCTION)
                {
                    c_FMKCPU_ClkFunctions_apcb[f_clkPort_e].EnableClk_pcb();
                }
                else
                {
                    Ret_e = RC_WARNING_NO_OPERATION;
                }

            }
            
            break;
        }
        case FMKCPU_CLOCKPORT_OPE_DISABLE:
        {
            if (c_FMKCPU_ClkFunctions_apcb[f_clkPort_e].DisableClk_pcb != (t_cbFMKCPU_ClockDisable *)NULL_FUNCTION)
            {
                c_FMKCPU_ClkFunctions_apcb[f_clkPort_e].DisableClk_pcb();
            }
            else
            {
                Ret_e = RC_WARNING_NO_OPERATION;
            }
            break;
        }
        case FMKCPU_CLOCKPORT_OPE_NB:
        default:
            Ret_e = RC_ERROR_PARAM_NOT_SUPPORTED;
            break;
        }
    }
    return Ret_e;
}

/*********************************
 * FMKCPU_Set_WwdgCfg
 *********************************/
t_eReturnCode FMKCPU_Set_WwdgCfg(t_eFMKCPu_WwdgResetPeriod f_period_e)
{
    t_eReturnCode Ret_e = RC_OK;
    HAL_StatusTypeDef bspRet_e = HAL_OK;

    Ret_e = FMKCPU_Set_HwClock(FMKCPU_RCC_CLK_WWDG, FMKCPU_CLOCKPORT_OPE_ENABLE);
    if(Ret_e == RC_OK)
    {
        Ret_e = FMKCPU_Set_NVICState(FMKCPU_NVIC_WWDG_IRQN ,FMKCPU_NVIC_OPE_ENABLE);
    }
    if(Ret_e == RC_OK)
    {
        g_wwdgInfos_s.Instance       = WWDG;
        g_wwdgInfos_s.Init.Prescaler = c_FMKCPU_WwdgPeriodcfg_ua16[f_period_e].psc_u16;
        g_wwdgInfos_s.Init.Counter   = c_FMKCPU_WwdgPeriodcfg_ua16[f_period_e].reload_u16;
        g_wwdgInfos_s.Init.Window    = (t_uint32)0x0FFF;
        g_wwdgInfos_s.Init.EWIMode   = WWDG_EWI_ENABLE;
        bspRet_e = HAL_WWDG_Init(&g_wwdgInfos_s);

        if(bspRet_e != HAL_OK)
        {
            Ret_e = RC_ERROR_WRONG_STATE;
            ASSERT((t_uint16)Ret_e);
        }
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_ResetWwdg
 *********************************/
t_eReturnCode FMKCPU_ResetWwdg(void)
{
    HAL_StatusTypeDef bspRet_e = HAL_OK;
    t_eReturnCode Ret_e = RC_OK;
    bspRet_e = HAL_WWDG_Refresh(&g_wwdgInfos_s);

    if(bspRet_e != HAL_OK)
    {
        Ret_e = RC_ERROR_WRONG_RESULT;
        ASSERT((t_uint16)Ret_e);
    }
    return Ret_e;
}

/***********************************
 * FMKCPU_RqstDmaInit
 ***********************************/
t_eReturnCode FMKCPU_RqstDmaInit(   t_eFMKCPU_DmaRqst f_DmaRqstType,
                                    t_eFMKCPU_DmaType f_Type_e,
                                    void *f_ModuleHandle_pv)
{
    t_eReturnCode Ret_e = RC_OK;
    HAL_StatusTypeDef bspRet_e = HAL_OK;
    t_eFMKCPU_DmaChnl channel_e;
    t_eFMKCPU_DmaController dmaCtrl_e;
    t_sFMKCPU_DmaChnlInfo * DmaChnl_ps;

    if (f_DmaRqstType >= FMKCPU_DMA_RQSTYPE_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    } 
    if(f_ModuleHandle_pv == (void *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
        ASSERT((t_uint16)Ret_e);
    }
    if(Ret_e == RC_OK)
    {
        //--------- Reach Information ---------//
        dmaCtrl_e = c_FMKCPU_DmaRqstCfg_as[f_DmaRqstType].Ctrl_e;
        channel_e = c_FMKCPU_DmaRqstCfg_as[f_DmaRqstType].Chnl_e;
        DmaChnl_ps = &g_DmaInfo_as[dmaCtrl_e].channel_as[channel_e];

        //--------- Check validity ---------//
        if(DmaChnl_ps->isChnlConfigured_b == (t_bool)True)
        {
            Ret_e = RC_ERROR_ALREADY_CONFIGURED;
            ASSERT((t_uint16)Ret_e);
        }
        if(Ret_e == RC_OK)
        {
            //--------- configure hardware clock to access register ---------//
            Ret_e = s_FMKCPU_SetDmaHwInit(dmaCtrl_e);

            if(Ret_e == RC_OK)
            {
                //--------- Configure Dma channel NVIC priority ---------//
                Ret_e = FMKCPU_Set_NVICState(   DmaChnl_ps->c_IRQNType_e, 
                                                FMKCPU_NVIC_OPE_ENABLE);
            }
            if(Ret_e == RC_OK)
            {   
                //--------- Configure Dma Channel ---------//
                Ret_e = s_FMKCPU_Set_DmaBspCfg( f_DmaRqstType, 
                                                f_Type_e,
                                                &DmaChnl_ps->bspDma_s,
                                                c_FMKCPU_DmaRqstCfg_as[f_DmaRqstType].transfPrio_e,
                                                (t_uFMKCPU_DmaHandleType *)f_ModuleHandle_pv);
            }
            if(Ret_e == RC_OK)
            {
                //---------call Bsp Init ---------//
                bspRet_e = HAL_DMA_Init(&DmaChnl_ps->bspDma_s);
                if(bspRet_e == HAL_OK)
                {
                    //------ Link DMA Management ------//
                    Ret_e = s_FMKCPU_LinkDma( f_Type_e,
                                            &DmaChnl_ps->bspDma_s,
                                            (t_uFMKCPU_DmaHandleType *)f_ModuleHandle_pv);

                    if(Ret_e == RC_OK)
                    {
                        DmaChnl_ps->isChnlConfigured_b = (t_bool)True;
                        //--------- Enable The Complete Callback ---------//
                        __HAL_DMA_ENABLE_IT(&DmaChnl_ps->bspDma_s, DMA_IT_TC); // transfer-complete
                    }
                }
                else
                {   
                    Ret_e = RC_ERROR_WRONG_RESULT;
                }
            }
        }   
    }

    return Ret_e;
}

/***********************************
 * FMKCPU_GetOscRccSrc
 ***********************************/
t_eReturnCode FMKCPU_GetOscRccSrc(  t_eFMKCPU_ClockPort f_clockPort_e,
                                    t_eFMKCPU_SysClkOsc * f_ClkOsc_pe)
{
    t_eReturnCode Ret_e = RC_OK;

    if(f_clockPort_e >= FMKCPU_RCC_CLK_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if(f_ClkOsc_pe == (t_eFMKCPU_SysClkOsc *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
        ASSERT((t_uint16)Ret_e);
    }
    if(Ret_e == RC_OK)
    {
        *f_ClkOsc_pe = c_FmkCpu_RccClockOscSrc_ae[f_clockPort_e];
    }

    return Ret_e;
}

/***********************************
 * FMKCPU_SysClkValue
 ***********************************/
t_eReturnCode FMKCPU_GetSysClkValue(    t_eFMKCPU_SysClkOsc f_ClkOsc_e,
                                        t_uint16 * f_OscValueMHz_pu16)
{
    t_eReturnCode Ret_e = RC_OK;

    if(f_ClkOsc_e >= FMKCPU_SYS_CLOCK_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if(f_OscValueMHz_pu16 == (t_uint16 *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
        ASSERT((t_uint16)Ret_e);
    }
    if(g_IsSysClkInit_b == (t_bool)False)
    {
        Ret_e = RC_WARNING_BUSY;
        ASSERT((t_uint16)Ret_e);
    }
    if(Ret_e == RC_OK)
    {
        *f_OscValueMHz_pu16 = (t_uint16)g_SysClockValue_ua8[f_ClkOsc_e];
    }

    return Ret_e;
}
//********************************************************************************
//                      Local functions - Implementation
//********************************************************************************
/***********************************
 * s_FMKCPU_SetDmaHwInit
 ***********************************/
static t_eReturnCode s_FMKCPU_SetDmaHwInit(t_eFMKCPU_DmaController f_dmaCtrl_e)
{
    t_eReturnCode Ret_e = RC_OK;
    static t_bool s_isDmaMuxCfgDone_b = False;

    t_uint8 idxDmaMux_u8;
    
    //--------- Set Dma Mux Hardware Clock ---------//
    if(s_isDmaMuxCfgDone_b == (t_bool)False)
    {
        for(idxDmaMux_u8 = (t_uint8)0 ; 
             (idxDmaMux_u8 < FMKCPU_DMA_MUX_NB) 
         &&  (Ret_e == RC_OK) ; 
            idxDmaMux_u8++)
        {
            Ret_e = FMKCPU_Set_HwClock(c_FMKCPU_DmaMuxRccMapp_ae[idxDmaMux_u8], FMKCPU_CLOCKPORT_OPE_ENABLE);
        }
        if(Ret_e == RC_OK)
        {
            s_isDmaMuxCfgDone_b = True;
        }
    }

    //--------- Set Dma Controller Hardware Clock ---------//
    if(Ret_e == RC_OK)
    {
        if(g_DmaCtrlState_ae[f_dmaCtrl_e] == FMKCPU_CLOCKPORT_OPE_DISABLE)
        {
            Ret_e = FMKCPU_Set_HwClock(g_DmaInfo_as[f_dmaCtrl_e].c_clock_e, FMKCPU_CLOCKPORT_OPE_ENABLE);
            if(Ret_e == RC_OK)
            {
                g_DmaCtrlState_ae[f_dmaCtrl_e] = FMKCPU_CLOCKPORT_OPE_ENABLE;
            }
        }
    }

    return Ret_e;
}
/***********************************
 * s_FMKCPU_SetDmaBspCfg
 ***********************************/
static t_eReturnCode s_FMKCPU_Set_DmaBspCfg(t_eFMKCPU_DmaRqst f_RqstType_e,
                                                t_eFMKCPU_DmaType f_Type_e,
                                                DMA_HandleTypeDef * f_bspDma_s,
                                                t_eFMKCPU_DmaTransferPriority f_dmaPrio_e,
                                                t_uFMKCPU_DmaHandleType * f_modHandle_pu)
{
    t_eReturnCode Ret_e = RC_OK;
    t_uint32 bspPriority_u32 = 0;

    if(f_RqstType_e >= FMKCPU_DMA_RQSTYPE_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if(f_bspDma_s == (DMA_HandleTypeDef *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
        ASSERT((t_uint16)Ret_e);
    }
    if(Ret_e == RC_OK)
    {
        Ret_e = s_FMKCPU_Get_DmaBspPriority(f_dmaPrio_e, &bspPriority_u32);
    }
    if(Ret_e == RC_OK)
    {
        //------ Set Priority ------//
        f_bspDma_s->Init.Priority = bspPriority_u32;
        
        //------ Set request dma Init ------//
        Ret_e = FMKCPU_SetRequestType(f_RqstType_e, f_bspDma_s);

        //------ Set Init Depending On Dma Type ------//
        if(Ret_e == RC_OK)
        {
            switch (f_Type_e)
            {
                case FMKCPU_DMA_TYPE_ADC:
                {
                    f_bspDma_s->Init.Direction = DMA_PERIPH_TO_MEMORY;
                    f_bspDma_s->Init.Mode      = FMKCPU_ADC_DMA_MODE;
                    f_bspDma_s->Init.PeriphInc = DMA_PINC_DISABLE;
                    f_bspDma_s->Init.MemInc    = DMA_MINC_ENABLE;
                    f_bspDma_s->Init.MemDataAlignment = DMA_MDATAALIGN_WORD;
                    f_bspDma_s->Init.PeriphDataAlignment = DMA_PDATAALIGN_WORD;
                
                    break;
                }
                case FMKCPU_DMA_TYPE_UART_RX:
                {
                    f_bspDma_s->Init.Direction = DMA_PERIPH_TO_MEMORY;
                    f_bspDma_s->Init.Mode      = FMKCPU_UART_RX_DMA_MODE;
                    f_bspDma_s->Init.PeriphInc = DMA_PINC_DISABLE;
                    f_bspDma_s->Init.MemInc    = DMA_MINC_ENABLE;
                    f_bspDma_s->Init.MemDataAlignment     = DMA_MDATAALIGN_BYTE;
                    f_bspDma_s->Init.PeriphDataAlignment  = DMA_PDATAALIGN_BYTE;
                    
                    break;
                }
                case FMKCPU_DMA_TYPE_UART_TX:
                {
                    f_bspDma_s->Init.Direction = DMA_MEMORY_TO_PERIPH;
                    f_bspDma_s->Init.Mode      = FMKCPU_UART_TX_DMA_MODE;
                    f_bspDma_s->Init.PeriphInc = DMA_PINC_DISABLE;
                    f_bspDma_s->Init.MemInc    = DMA_MINC_ENABLE;
                    f_bspDma_s->Init.MemDataAlignment    = DMA_MDATAALIGN_BYTE;
                    f_bspDma_s->Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
                    break;
                }
                case FMKCPU_DMA_TYPE_USART_RX:
                {
                    //DMA_PERIPH_TO_MEMORY
                    Ret_e = RC_ERROR_MISSING_CONFIG;
                    break;
                }
                case FMKCPU_DMA_TYPE_USART_TX:
                {
                    //DMA_MEMORY_TO_PERIPH
                    Ret_e = RC_ERROR_MISSING_CONFIG;
                    break;
                }
                case FMKCMAC_DMA_TYPE_TIM_CHNL_ECDR_CC1:
                {
                    f_bspDma_s->Init.Direction = DMA_PERIPH_TO_MEMORY;
                    f_bspDma_s->Init.Mode      = FMKCPU_TIM_CHNL_ECDR_CC1_MODE;
                    f_bspDma_s->Init.PeriphInc = DMA_PINC_DISABLE;
                    f_bspDma_s->Init.MemInc    = DMA_MINC_ENABLE;
                    f_bspDma_s->Init.MemDataAlignment    = DMA_MDATAALIGN_BYTE;
                    f_bspDma_s->Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
                    break;
                }
                case FMKCMAC_DMA_TYPE_TIM_CHNL_ECDR_CC2:
                {
                    f_bspDma_s->Init.Direction = DMA_PERIPH_TO_MEMORY;
                    f_bspDma_s->Init.Mode      = FMKCPU_TIM_CHNL_ECDR_CC2_MODE;
                    f_bspDma_s->Init.PeriphInc = DMA_PINC_DISABLE;
                    f_bspDma_s->Init.MemInc    = DMA_MINC_ENABLE;
                    f_bspDma_s->Init.MemDataAlignment    = DMA_MDATAALIGN_BYTE;
                    f_bspDma_s->Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
                }
                case FMKCPU_DMA_TYPE_SPI:
                {
                    Ret_e = RC_ERROR_MISSING_CONFIG;
                    break;
                }
                case FMKCPU_DMA_TYPE_NB:
                default:
                {
                    Ret_e = RC_ERROR_NOT_SUPPORTED;
                    break;
                }
            }
        }
    }

    return Ret_e;
}

/***********************************
 * s_FMKCPU_Get_DmaBspPriority
 ***********************************/
static t_eReturnCode s_FMKCPU_Get_DmaBspPriority(t_eFMKCPU_DmaTransferPriority f_priority_e, t_uint32 * f_bspPriority_pu32)
{
    t_eReturnCode Ret_e = RC_OK;

    if(f_priority_e >= FMKCPU_DMA_TRANSPRIO_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if(f_bspPriority_pu32 == (t_uint32 *)0)
    {
        Ret_e = RC_ERROR_PTR_NULL;
        ASSERT((t_uint16)Ret_e);
    }
    if(Ret_e == RC_OK)
    {
        switch(f_priority_e)
        {
            case FMKCPU_DMA_TRANSPRIO_LOW:
                *f_bspPriority_pu32 = DMA_PRIORITY_LOW;
                break;
            case FMKCPU_DMA_TRANSPRIO_MEDIUM:
                *f_bspPriority_pu32 = DMA_PRIORITY_MEDIUM;
                break;
            case FMKCPU_DMA_TRANSPRIO_HIGH:
                *f_bspPriority_pu32 = DMA_PRIORITY_HIGH;
                break;
            case FMKCPU_DMA_TRANSPRIO_VERY_HIGH:
                *f_bspPriority_pu32 = DMA_PRIORITY_VERY_HIGH;
                break;
            case FMKCPU_DMA_TRANSPRIO_NB:
            default:
                Ret_e = RC_ERROR_NOT_SUPPORTED;
                break;
        }
    }
    return Ret_e;
}

/***********************************
 * s_FMKCPU_LinkDma
 ***********************************/
static t_eReturnCode s_FMKCPU_LinkDma(  t_eFMKCPU_DmaType f_DmaType_e,
                                        DMA_HandleTypeDef * f_bspDma_s,
                                        t_uFMKCPU_DmaHandleType * f_modHandle_pu)
{
    t_eReturnCode Ret_e = RC_OK;

    if(f_DmaType_e >= FMKCPU_DMA_TYPE_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if((f_modHandle_pu == (t_uFMKCPU_DmaHandleType *)NULL)
    || (f_bspDma_s == (DMA_HandleTypeDef *)NULL))
    {
        Ret_e = RC_ERROR_PTR_NULL;
        ASSERT((t_uint16)Ret_e);
    }
    if(Ret_e == RC_OK)
    {
        switch (f_DmaType_e)
        {   
            case FMKCPU_DMA_TYPE_ADC:
                __HAL_LINKDMA(&f_modHandle_pu->adcHandle_s, DMA_Handle, *f_bspDma_s);
                break;
          
            case FMKCPU_DMA_TYPE_UART_RX:
                __HAL_LINKDMA((&f_modHandle_pu->uartHandle_s), hdmarx, *f_bspDma_s);
                break;

            case FMKCPU_DMA_TYPE_UART_TX:
                __HAL_LINKDMA((&f_modHandle_pu->uartHandle_s), hdmatx, *f_bspDma_s);
                break;
            
            case FMKCPU_DMA_TYPE_USART_RX:
                __HAL_LINKDMA((&f_modHandle_pu->usartHandle_s), hdmarx, *f_bspDma_s);
                break;
            
            case FMKCPU_DMA_TYPE_USART_TX:
                __HAL_LINKDMA((&f_modHandle_pu->usartHandle_s), hdmatx, *f_bspDma_s);
                break;
            case FMKCMAC_DMA_TYPE_TIM_CHNL_ECDR_CC1:
                __HAL_LINKDMA((&f_modHandle_pu->timHandle_s), hdma[TIM_DMA_ID_CC1], *f_bspDma_s);
                break;
            case FMKCMAC_DMA_TYPE_TIM_CHNL_ECDR_CC2:
                __HAL_LINKDMA((&f_modHandle_pu->timHandle_s), hdma[TIM_DMA_ID_CC2], *f_bspDma_s);
                break;
            case FMKCPU_DMA_TYPE_SPI:
            case FMKCPU_DMA_TYPE_NB:
            default:
                Ret_e = RC_ERROR_NOT_SUPPORTED;
                break;
        }
    }

    return Ret_e;
}

/*********************************
 * FMKCPU_PRIVATE_GetHandleTypeDef
 *********************************/
DMA_HandleTypeDef * FMKCPU_PRIVATE_GetHandleTypeDef(t_eFMKCPU_DmaController f_dmaCtrl_e, t_eFMKCPU_DmaChnl f_chnle_e)
{
    if(g_DmaInfo_as[f_dmaCtrl_e].channel_as[f_chnle_e].isChnlConfigured_b == (t_bool)False)
    {
        ASSERT((t_uint16)0);
    }
    return (DMA_HandleTypeDef *)(&g_DmaInfo_as[f_dmaCtrl_e].channel_as[f_chnle_e].bspDma_s);
}
//********************************************************************************
//                      Local functions - Implementation
//********************************************************************************
/*********************************
 * s_FMKCPU_Operational
 *********************************/
static t_eReturnCode s_FMKCPU_Operational(void)
{
    t_eReturnCode Ret_e;
    t_uint8 idxDma_u8;
    t_uint8 idxDmaChnl_u8;
    t_sFMKCPU_DmaChnlInfo * dmaChnlInfo_ps;
    t_uint32 bspError_u32;

    for(idxDma_u8 = (t_uint8)0 ; idxDma_u8 < FMKCPU_DMA_CTRL_NB ; idxDma_u8++)
    {
        for(idxDmaChnl_u8 = (t_uint8)0 ; idxDmaChnl_u8 < FMKCPU_DMA_CHANNEL_NB ; idxDmaChnl_u8++)
        {
            dmaChnlInfo_ps = (t_sFMKCPU_DmaChnlInfo *)(&g_DmaInfo_as[idxDma_u8].channel_as[idxDmaChnl_u8]);
            if(dmaChnlInfo_ps->isChnlConfigured_b == (t_bool)TRUE)
            {
                bspError_u32 = HAL_DMA_GetError(&dmaChnlInfo_ps->bspDma_s);

                if((bspError_u32 != HAL_DMA_ERROR_NONE)
                || (dmaChnlInfo_ps->ErrorDetected_b == (t_bool)TRUE))
                {
                    if(dmaChnlInfo_ps->ErrorDetected_b == (t_bool)FALSE)
                    {
                        dmaChnlInfo_ps->ErrorDetected_b = (t_bool)TRUE;
                    }

                    Ret_e = s_FMKCPU_DmaPerformDiagnostic(idxDma_u8, idxDmaChnl_u8, bspError_u32);
                }
            }
        }
    }

    
    return Ret_e;
}

/*********************************
 * s_FMKCPU_Get_BspNVICPriority
 *********************************/
static t_eReturnCode s_FMKCPU_Get_BspNVICPriority(t_eFMKCPU_NVICPriority f_priority_e, t_uint32 *f_BspNVICPriority_pu32)
{
    t_eReturnCode Ret_e = RC_OK;

    if (f_BspNVICPriority_pu32 == (t_uint32 *)NULL)
    {
        Ret_e = RC_ERROR_PTR_NULL;
        ASSERT((t_uint16)Ret_e);
    }
    if (f_priority_e >= FMKCPU_NVIC_PRIORITY_NB)
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
        ASSERT((t_uint16)Ret_e);
    }
    if (Ret_e == RC_OK)
    {
        switch (f_priority_e)
        {
            case FMKCPU_NVIC_PRIORITY_LOW:
                *f_BspNVICPriority_pu32 = 6;
                break;
            case FMKCPU_NVIC_PRIORITY_MEDIUM:
                *f_BspNVICPriority_pu32 = 3;
                break;
            case FMKCPU_NVIC_PRIORITY_HIGH:
                *f_BspNVICPriority_pu32 = 0;
                break;

            case FMKCPU_NVIC_PRIORITY_NB:
            default:
                Ret_e = RC_ERROR_PARAM_NOT_SUPPORTED;
                break;
        }
    }
    return Ret_e;
}

/*********************************
 * s_FMKCPU_DmaPerformDiagnostic
 *********************************/
static t_eReturnCode s_FMKCPU_DmaPerformDiagnostic( t_eFMKCPU_DmaController f_dmaCtrl_e, 
                                                    t_eFMKCPU_DmaChnl f_dmaChnl_e,
                                                    t_uint32  f_bspError_u32)
{
    t_eReturnCode Ret_e;
    t_uint16 diagInfo1_u16;
    t_sFMKCPU_DmaChnlInfo * dmaChnlInfo_ps;
    t_uint32 currentTime_u32;

    if((f_dmaCtrl_e >= FMKCPU_DMA_CTRL_NB)
    || (f_dmaChnl_e >= FMKCPU_DMA_CHANNEL_NB))
    {
        Ret_e = RC_ERROR_PARAM_INVALID;
    }
    else 
    {
        Ret_e = RC_OK;
        diagInfo1_u16 = (t_uint16)(f_dmaCtrl_e << (t_uint8)8 | (t_uint8)f_dmaChnl_e);
        FMKCPU_GetTick(&currentTime_u32);
        dmaChnlInfo_ps = (t_sFMKCPU_DmaChnlInfo *)(&g_DmaInfo_as[f_dmaCtrl_e].channel_as[f_dmaChnl_e]);

        switch(f_bspError_u32)
        {
            case HAL_DMA_ERROR_NONE:
                dmaChnlInfo_ps->chnlErr_e = FMKCPU_DMA_ERRSTATE_OK;
            break;
            case HAL_DMA_ERROR_TE:
                dmaChnlInfo_ps->chnlErr_e = FMKCPU_DMA_ERRSTATE_TRANSFER_ERROR;
            break;
            case HAL_DMA_ERROR_NO_XFER:
                dmaChnlInfo_ps->chnlErr_e = FMKCPU_DMA_ERRSTATE_XFER;
            break;
            case HAL_DMA_ERROR_TIMEOUT:
                dmaChnlInfo_ps->chnlErr_e = FMKCPU_DMA_ERRSTATE_TIMEOUT;
            break;
            case HAL_DMA_ERROR_NOT_SUPPORTED:
                dmaChnlInfo_ps->chnlErr_e = FMKCPU_DMA_ERRSTATE_NOT_SUPPORTED;
            break;
            case HAL_DMA_ERROR_SYNC:
                dmaChnlInfo_ps->chnlErr_e = FMKCPU_DMA_ERRSTATE_SYNC;
            break;
            case HAL_DMA_ERROR_REQGEN:
                dmaChnlInfo_ps->chnlErr_e = FMKCPU_DMA_ERRSTATE_REQGEN;
            break;
            default:
            break;
        }
        if(dmaChnlInfo_ps->chnlErr_e != FMKCPU_DMA_ERRSTATE_OK)
        {
            APPSDM_ReportDiagEvnt(  APPSDM_DIAG_ITEM_FMK_CPU_OPE_ERROR,
                                    APPSDM_DIAG_ITEM_REPORT_FAIL,
                                    (t_uint16)diagInfo1_u16,
                                    (t_uint16)dmaChnlInfo_ps->chnlErr_e);
        }
        else 
        {
            dmaChnlInfo_ps->ErrorDetected_b = (t_bool)FALSE;
            APPSDM_ReportDiagEvnt(  APPSDM_DIAG_ITEM_FMK_CPU_OPE_ERROR,
                                    APPSDM_DIAG_ITEM_REPORT_PASS,
                                    (t_uint16)diagInfo1_u16,
                                    (t_uint16)0);
        }
    }

    return Ret_e;
}
/******************************************
 * BSP CALLBACK IMPLEMENTATION
 *****************************************/


/***********************************
 * SysTick_Handler
 ***********************************/
void SysTick_Handler(void) { return HAL_IncTick(); }


/***********************************
 * WWDG_IRQHandler
 ***********************************/
void WWDG_IRQHandler(void)
{
    if (g_wwdgInfos_s.Instance->SR & WWDG_SR_EWIF)
    {
        // Effacer le drapeau d'interruption précoce
        g_wwdgInfos_s.Instance->SR &= ~WWDG_SR_EWIF;

        // deal with error
    }
}
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
