/**
 * @file        FMK_CPU.h
 * @brief       Template_BriefDescription.
 * @note        TemplateDetailsDescription.\n
 *
 * @author      xxxxxx
 * @date        jj/mm/yyyy
 * @version     1.0
 */
  
#ifndef FMKCPU_H_INCLUDED
#define FMKCPU_H_INCLUDED





    // ********************************************************************
    // *                      Includes
    // ********************************************************************
    #include "FMK_CFG/FMKCFG_ConfigFiles/FMKCPU_ConfigPublic.h"
    #include "TypeCommon.h"
    // ********************************************************************
    // *                      Defines
    // ********************************************************************
    #define FMKCPU_PWM_MAX_DUTY_CYLCE ((t_uint16)1000) /**< Max duty cycle allowed */
    #define FMKCPU_PWM_MIN_DUTY_CYLCE ((t_uint16)0)    /**< Min dutyCycle allowed */

    /**< Macro to know in Hz the System Frequency */
    #define FMKCPU_FREQ_SYSTEM_HZ ((t_uint32))
    // ********************************************************************
    // *                      Types
    // ********************************************************************
    //-----------------------------ENUM TYPES-----------------------------//
    /* CAUTION : Automatic generated code section for Enum: Start */

    /* CAUTION : Automatic generated code section for Enum: End */

    /**< Enuum for crcc clock port operation */
    typedef enum 
    {
        FMKCPU_CLOCKPORT_OPE_ENABLE = 0x0U,     /**< The operation to make on rcc clock port will be to enable it */
        FMKCPU_CLOCKPORT_OPE_DISABLE,           /**< The operation to make on rcc clock port will be to disable it */

        FMKCPU_CLOCKPORT_OPE_NB                 /**< Number of operation on rcc clock state */
    } t_eFMKCPU_ClockPortOpe;

    /**< enum for NVIC operation state */
    typedef enum 
    {
        FMKCPU_NVIC_OPE_ENABLE = 0x0U,          /**< The operation to make on NVIC is to enable it */
        FMKCPU_NVIC_OPE_DISABLE,                /**< The operation to make on NVIC is to disable it */
        FMKCPU_NVIC_OPE_CLEAR_IT,                /**< Cleat Interrupt in Queue */

        FMKCPU_NVIC_OPE_NB
    } t_eFMKCPU_NVIC_Ope;
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
    *	@brief      Perform all Init action for this module.\n
    *	@note       Set to default value all globals structure that
    *                store information for each signals.\n
    *
    */
    t_eReturnCode FMKCPU_Init(void);
    /**
    *
    *	@brief      Perform all Cyclic action for this module.\n
    *	@note       In preOpe mode this module makes the configuration of the system clock and 
    *               watchdogs configuration.\n 
    *               In ope mode, this module makesdiag on timer channel currently used, and 
    *               called the appropriate callback if an error occured + call APPDEM
    *               to reference error.\n
    *
    */
    t_eReturnCode FMKCPU_Cyclic(void);
    /**
    *
    *	@brief Function to know the module state.\n 
    *
    *	@param[in]  f_State_pe : store the value, value from @ref t_eCyclicModState
    *
    *   @retval RC_OK                             @ref RC_OK
    *   @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NUL
    */
    t_eReturnCode FMKCPU_GetState(t_eCyclicModState *f_State_pe);
    /**
    *
    *	@brief      Get the last captured CPU core fault information.\n
    *
    *	@param[out] f_faultInfo_ps : storage for the last fault snapshot.
    *
    *   @retval RC_OK                             @ref RC_OK
    *   @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
    */
    t_eReturnCode FMKCPU_GetLastCoreFaultInfo(t_sFMKCPU_CoreFaultInfo *f_faultInfo_ps);
    /**
    *
    *	@brief Function to update the module state.\n
    *
    *	@param[in]  f_State_e : the new value, value from @ref t_eCyclicModState
    *
    *   @retval RC_OK                             @ref RC_OK
    */
    t_eReturnCode FMKCPU_SetState(t_eCyclicModState f_State_e);
    /**
    *
    *	@brief      Set the system clock configuration.\n
    *   @note       This function has to be first one to be call in the Software.\n
    *               Configure the Clocks used and the frequency for each clock.\n
    *
    *
    *   @retval RC_OK                             @ref RC_OK
    *   @retval RC_ERROR_WRONG_STATE              @ref RC_ERROR_WRONG_STATE
    */
    t_eReturnCode FMKCPU_Set_SysClockCfg(t_eFMKCPU_CoreClockSpeed f_SystemCoreFreq_e);
    /**
    *
    *	@brief      Set a Delay without bloxking other interruption.\n
    *
    *	@param[in]  f_delayms_u32 : period delay in millisecond.\n
    *
    */
    void FMKCPU_Set_Delay(t_uint32 f_delayms_u32);
    /**
    *
    *	@brief      Get a tick from clock freqency.\n
    *
    *	@param[in]  f_tickms_pu32 : store the tick value in millisecond.\n
    *
    *   @retval RC_OK                             @ref RC_OK
    *   @retval RC_ERROR_WRONG_STATE              @ref RC_ERROR_WRONG_STATE
    */
    void FMKCPU_GetTick(t_uint32 * f_tickms_pu32);
    /**
    *
    *	@brief      Set the hardware configuration.\n
    *   @note       Reset of all peripherals, Initializes the Flash interface and the Systick..\n              
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_WRONG_RESULT             @ref RC_ERROR_WRONG_RESULT
    */
   t_eReturnCode FMKCPU_Set_HardwareInit(void);
    /**
    *
    *	@brief      Set the priority for a NVIC and the state ON/OFF\n
    *   @note       This function is called to set the interruption priority
    *               for f_IRQN_e interruption.\n 
    *               If an interruption (2) occur while another Interruption (1) is running, 
    *               depending on the value of c_FMKCPU_IRQNPriority_ae (2) that will interrupt or not
    *               the interruption (1).\n
    *               This function also disable the IRQN interruption if needed.\n
    *
    *	@param[in]  f_IRQN_e     : enum value for IRQN type, value from @ref t_eFMKCPU_IRQNType
    *	@param[in]  f_OpeState_e : enum value for  pose state,value from @ref t_eFMKCPU_NVIC_Ope
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
    *  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
    */
    t_eReturnCode FMKCPU_Set_NVICState(t_eFMKCPU_IRQNType f_IRQN_e, t_eFMKCPU_NVIC_Ope f_OpeState_e);
    /**
    *
    *	@brief      Set the RCC clock state.\n
    *   @note       In order to write down bit in everry register (ADC,GPIO,TIM,etc),
    *               the RCC clock has to be enable first. This function enable or disable
    *               the RCC clock reference to f_clkPort_e.\n
    *              
    *
    *	@param[in]  f_clkPort_e     : enum value for RCC clock, value from @ref t_eFMKCPU_ClockPort
    *	@param[in]  f_OpeState_e    : enum value for priority, value from @ref t_eFMKCPU_NVICPriority
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
    *  @retval RC_ERROR_PARAM_NOT_SUPPORTED      @ref RC_ERROR_PARAM_NOT_SUPPORTED
    *  @retval RC_WARNING_NO_OPERATION           @ref RC_WARNING_NO_OPERATION
    */
    t_eReturnCode FMKCPU_Set_HwClock(t_eFMKCPU_ClockPort f_clkPort_e, 
                                       t_eFMKCPU_ClockPortOpe f_OpeState_e);
    /**
    *
    *	@brief      Set the watchdog configuration.\n
    *   @note       Set the watchdogs configuration and active it imeddiately.\n              
    *
    *	@param[in]  f_period_e      : enum value for period before reset, value from @ref t_eFMKCPu_WwdgResetPeriod
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
    *  @retval RC_ERROR_WRONG_STATE              @ref RC_ERROR_WRONG_STATE
    */
    t_eReturnCode FMKCPU_Set_WwdgCfg(t_eFMKCPu_WwdgResetPeriod f_period_e);
    /**
    *
    *	@brief      Reset the watchdogs counter.\n
    *
    *  @retval RC_OK                             @ref RC_OK
    *  @retval RC_ERROR_WRONG_STATE              @ref RC_ERROR_WRONG_STATE
    */
    void FMKCPU_RearmWwdg(void);
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
    t_eReturnCode FMKCPU_RqstDmaInit(   t_eFMKCPU_DmaRqst f_DmaRqstType,
                                        t_eFMKCPU_DmaType f_dmaType_e,
                                        void *f_ModuleHandle_pv);

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
    t_eReturnCode FMKCPU_GetOscRccSrc(  t_eFMKCPU_ClockPort f_clockPort_e,
                                        t_eFMKCPU_SysClkOsc * f_ClkOsc_pe);
    /**
    *
    *	@brief      Return the effective frequency associated with an RCC clock port.\n
    *
    *	@param[in]  f_clockPort_e        : RCC clock port, value from @ref t_eFMKCPU_ClockPort
    *	@param[out] f_OscValueMHz_pu16   : storage for the current frequency in MHz.
    *
    *   @retval RC_OK                             @ref RC_OK
    *   @retval RC_ERROR_PARAM_INVALID            @ref RC_ERROR_PARAM_INVALID
    *   @retval RC_ERROR_PTR_NULL                 @ref RC_ERROR_PTR_NULL
    */
    t_eReturnCode FMKCPU_GetRccClockValue(t_eFMKCPU_ClockPort f_clockPort_e,
                                          t_uint16 *f_OscValueMHz_pu16);
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
    t_eReturnCode FMKCPU_GetSysClkValue(   t_eFMKCPU_SysClkOsc f_ClkOsc_e,
                                        t_uint16 * f_OscValueMHz_pu16);
    /**
    *
    *	@brief      DO NOT USE, Function to get the Handle Type def for IRQN_Handler Function
    *
    *	@param[in]  f_timer_e                : enum value for the timer, value from @ref t_eFMKTIM_Timer
    *
    *
    */
    DMA_HandleTypeDef * FMKCPU_PRIVATE_GetHandleTypeDef(t_eFMKCPU_DmaController f_dmaCtrl_e, t_eFMKCPU_DmaChnl f_chnle_e);
#endif // FMKCPU_H_INCLUDED           
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
