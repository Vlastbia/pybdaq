cimport libc.stdint
cimport libc.stddef
cimport libcpp

from libc.stdint cimport (
    uint8_t,
    int16_t,
    int32_t)
from libc.stddef cimport wchar_t


cdef extern from "bdaqctrl.h" namespace "Automation::BDaq":
    ctypedef enum TerminalBoard:
        WiringBoard
        PCLD8710
        PCLD789
        PCLD8115

    ctypedef enum ModuleType:
        DaqAny
        DaqGroup
        DaqDevice
        DaqAi
        DaqAo
        DaqDio
        DaqCounter

    ctypedef enum AccessMode:
        ModeRead
        ModeWrite
        ModeWriteWithReset
        ModeReserved

    ctypedef enum MathIntervalType:
        RightOpenSet
        RightClosedBoundary
        RightOpenBoundary
        LeftOpenSet
        LeftClosedBoundary
        LeftOpenBoundary
        Boundless
        LOSROS
        LOSRCB
        LOSROB
        LCBROS
        LCBRCB
        LCBROB
        LOBROS
        LOBRCB
        LOBROB

    ctypedef struct MathInterval:
        libc.stdint.int32_t Type
        double Min
        double Max

    ctypedef enum AiChannelType:
        AllSingleEnded
        AllDifferential
        AllSeDiffAdj
        MixedSeDiffAdj

    ctypedef enum AiSignalType:
        SingleEnded
        Differential

    ctypedef enum FilterType:
        FilterNone
        LowPass
        HighPass
        BandPass
        BandStop

    ctypedef enum DioPortType:
        PortDi
        PortDo
        PortDio
        Port8255A
        Port8255C
        PortIndvdlDio

    ctypedef enum DioPortDir:
        Input
        LoutHin
        LinHout
        Output

    ctypedef enum DiOpenState:
        pullHighAllPort
        pullLowAllPort

    ctypedef enum SamplingMethod:
        EqualTimeSwitch
        Simultaneous

    ctypedef enum TemperatureDegree:
        Celsius
        Fahrenheit
        Rankine
        Kelvin

    ctypedef enum BurnoutRetType:
        Current
        ParticularValue
        UpLimit
        LowLimit
        LastCorrectValue

    ctypedef enum ValueUnit:
        Kilovolt
        Volt
        Millivolt
        Microvolt
        Kiloampere
        Ampere
        Milliampere
        Microampere
        CelsiusUnit

    ctypedef enum ValueRange:
        V_OMIT
        V_Neg15To15
        V_Neg10To10
        V_Neg5To5
        V_Neg2pt5To2pt5
        V_Neg1pt25To1pt25
        V_Neg1To1
        V_0To15
        V_0To10
        V_0To5
        V_0To2pt5
        V_0To1pt25
        V_0To1
        mV_Neg625To625
        mV_Neg500To500
        mV_Neg312pt5To312pt5
        mV_Neg200To200
        mV_Neg150To150
        mV_Neg100To100
        mV_Neg50To50
        mV_Neg30To30
        mV_Neg20To20
        mV_Neg15To15
        mV_Neg10To10
        mV_Neg5To5
        mV_0To625
        mV_0To500
        mV_0To150
        mV_0To100
        mV_0To50
        mV_0To20
        mV_0To15
        mV_0To10
        mA_Neg20To20
        mA_0To20
        mA_4To20
        mA_0To24
        V_Neg2To2
        V_Neg4To4
        V_Neg20To20
        Jtype_0To760C
        Ktype_0To1370C
        Ttype_Neg100To400C
        Etype_0To1000C
        Rtype_500To1750C
        Stype_500To1750C
        Btype_500To1800C
        Pt392_Neg50To150
        Pt385_Neg200To200
        Pt385_0To400
        Pt385_Neg50To150
        Pt385_Neg100To100
        Pt385_0To100
        Pt385_0To200
        Pt385_0To600
        Pt392_Neg100To100
        Pt392_0To100
        Pt392_0To200
        Pt392_0To600
        Pt392_0To400
        Pt392_Neg200To200
        Pt1000_Neg40To160
        Balcon500_Neg30To120
        Ni518_Neg80To100
        Ni518_0To100
        Ni508_0To100
        Ni508_Neg50To200
        Thermistor_3K_0To100
        Thermistor_10K_0To100
        Jtype_Neg210To1200C
        Ktype_Neg270To1372C
        Ttype_Neg270To400C
        Etype_Neg270To1000C
        Rtype_Neg50To1768C
        Stype_Neg50To1768C
        Btype_40To1820C
        Jtype_Neg210To870C
        Rtype_0To1768C
        Stype_0To1768C
        Ttype_Neg20To135C
        UserCustomizedVrgStart
        UserCustomizedVrgEnd
        V_ExternalRefBipolar
        V_ExternalRefUnipolar

    ctypedef enum SignalPolarity:
        Negative
        Positive

    ctypedef enum SignalCountingType:
        CountingNone
        DownCount
        UpCount
        PulseDirection
        TwoPulse
        AbPhaseX1
        AbPhaseX2
        AbPhaseX4

    ctypedef enum OutSignalType:
        SignalOutNone
        ChipDefined
        NegChipDefined
        PositivePulse
        NegativePulse
        ToggledFromLow
        ToggledFromHigh

    ctypedef enum CounterCapability:
        Primary
        InstantEventCount
        OneShot
        TimerPulse
        InstantFreqMeter
        InstantPwmIn
        InstantPwmOut
        UpDownCount

    ctypedef enum CounterOperationMode:
        C8254_M0
        C8254_M1
        C8254_M2
        C8254_M3
        C8254_M4
        C8254_M5
        C1780_MA
        C1780_MB
        C1780_MC
        C1780_MD
        C1780_ME
        C1780_MF
        C1780_MG
        C1780_MH
        C1780_MI
        C1780_MJ
        C1780_MK
        C1780_ML
        C1780_MO
        C1780_MR
        C1780_MU
        C1780_MX

    ctypedef enum CounterValueRegister:
        CntLoad
        CntPreset
        CntHold
        CntOverCompare
        CntUnderCompare

    ctypedef enum CounterCascadeGroup:
        GroupNone
        Cnt0Cnt1
        Cnt2Cnt3
        Cnt4Cnt5
        Cnt6Cnt7

    ctypedef enum FreqMeasureMethod:
        AutoAdaptive
        CountingPulseBySysTime
        CountingPulseByDevTime
        PeriodInverse

    ctypedef enum ActiveSignal:
        ActiveNone
        RisingEdge
        FallingEdge
        BothEdge
        HighLevel
        LowLevel

    ctypedef enum TriggerAction:
        ActionNone
        DelayToStart
        DelayToStop

    ctypedef enum SignalPosition:
        InternalSig
        OnConnector
        OnAmsi

    ctypedef enum ErrorCode:
        Success
        #WarningIntrNotAvailable = 0xA0000000,
        #WarningParamOutOfRange = 0xA0000001,
        #WarningPropValueOutOfRange = 0xA0000002,
        #WarningPropValueNotSpted = 0xA0000003,
        #WarningPropValueConflict = 0xA0000004,
        #WarningVrgOfGroupNotSame = 0xA0000005,
        #ErrorHandleNotValid = 0xE0000000,
        #ErrorParamOutOfRange = 0xE0000001,
        #ErrorParamNotSpted = 0xE0000002,
        #ErrorParamFmtUnexpted = 0xE0000003,
        #ErrorMemoryNotEnough = 0xE0000004,
        #ErrorBufferIsNull = 0xE0000005,
        #ErrorBufferTooSmall = 0xE0000006,
        #ErrorDataLenExceedLimit = 0xE0000007,
        #ErrorFuncNotSpted = 0xE0000008,
        #ErrorEventNotSpted = 0xE0000009,
        #ErrorPropNotSpted = 0xE000000A, 
        #ErrorPropReadOnly = 0xE000000B,
        #ErrorPropValueConflict = 0xE000000C,
        #ErrorPropValueOutOfRange = 0xE000000D,
        #ErrorPropValueNotSpted = 0xE000000E,
        #ErrorPrivilegeNotHeld = 0xE000000F,
        #ErrorPrivilegeNotAvailable = 0xE0000010,
        #ErrorDriverNotFound = 0xE0000011,
        #ErrorDriverVerMismatch = 0xE0000012,
        #ErrorDriverCountExceedLimit = 0xE0000013,
        #ErrorDeviceNotOpened = 0xE0000014,      
        #ErrorDeviceNotExist = 0xE0000015,
        #ErrorDeviceUnrecognized = 0xE0000016,
        #ErrorConfigDataLost = 0xE0000017,
        #ErrorFuncNotInited = 0xE0000018,
        #ErrorFuncBusy = 0xE0000019,
        #ErrorIntrNotAvailable = 0xE000001A,
        #ErrorDmaNotAvailable = 0xE000001B,
        #ErrorDeviceIoTimeOut = 0xE000001C,
        #ErrorSignatureNotMatch
        #ErrorUndefined

    ErrorCode AdxEnumToString(
        wchar_t* enumTypeName,
        int32_t enumValue,
        int32_t enumStringLength,
        wchar_t* enumString)

    ErrorCode AdxStringToEnum(
        wchar_t* enumTypeName,
        wchar_t* enumString,
        int32_t* enumValue)

    enum:
        MAX_DEVICE_DESC_LEN

    cppclass DeviceInformation:
        libc.stdint.int32_t DeviceNumber
        AccessMode DeviceMode
        libc.stdint.int32_t ModuleIndex
        libc.stddef.wchar_t Description[MAX_DEVICE_DESC_LEN]

        DeviceInformation()
        DeviceInformation(
            libc.stdint.int32_t deviceNumber,
            AccessMode mode,
            libc.stdint.int32_t moduleIndex)
        DeviceInformation(
            libc.stddef.wchar_t* deviceDesc,
            AccessMode mode,
            libc.stdint.int32_t moduleIndex)
        void Init(
            libc.stdint.int32_t deviceNumber,
            libc.stddef.wchar_t* deviceDesc,
            AccessMode mode,
            libc.stdint.int32_t moduleIndex)

    #ErrorCode AdxDeviceGetLinkageInfo(
        #int32 deviceParent,
        #int32 index,
        #int32* deviceNumber,
        #wchar_t* description,
        #int32* subDeviceCount)

    #ErrorCode AdxGetValueRangeInformation(
        #ValueRange   type,         /*IN*/
        #int32        descBufSize,  /*IN*/
        #wchar_t      *description, /*OUT OPTIONAL*/
        #MathInterval *range,       /*OUT OPTIONAL*/
        #ValueUnit    *unit);        /*OUT OPTIONAL */

    #ErrorCode AdxGetSignalConnectionInformation(
        #SignalDrop     signal,      /*IN*/
        #int32          descBufSize, /*IN*/
        #wchar_t        *description,/*OUT OPTIONAL*/
        #SignalPosition *position);   /*OUT OPTIONAL*/

    cppclass DeviceCtrlBase:
        void Dispose()
        void Cleanup()
        ErrorCode UpdateProperties()

        #void addRemovedListener(DeviceEventListener& listener)
        #void removeRemovedListener(DeviceEventListener& listener)
        #void addReconnectedListener(DeviceEventListener& listener)
        #void removeReconnectedListener(DeviceEventListener& listener)
        #void addPropertyChangedListener(DeviceEventListener& listener)
        #void removePropertyChangedListener(DeviceEventListener& listener)

        void getSelectedDevice(DeviceInformation& x)
        ErrorCode setSelectedDevice(DeviceInformation& x)
        libcpp.bool getInitialized()
        libcpp.bool getCanEditProperty()
        void* getDevice()
        void* getModule()
        #virtual ICollection<DeviceTreeNode>* BDAQCALL getSupportedDevices() = 0;
        #virtual ICollection<AccessMode>*     BDAQCALL getSupportedModes() = 0;

    #
    # ANALOG INPUT
    #

    cppclass AiFeatures:
        int32_t getResolution()
        int32_t getDataSize()
        int32_t getDataMask()

        int32_t getChannelCountMax()
        #AiChannelType getChannelType()
        libcpp.bool getOverallValueRange()
        libcpp.bool getThermoSupported()
        #ICollection<ValueRange>* getValueRanges()
        #ICollection<BurnoutRetType>* getBurnoutReturnTypes()

        #ICollection<int32>* getCjcChannels()

        libcpp.bool getBufferedAiSupported()
        #SamplingMethod getSamplingMethod()
        int32_t getChannelStartBase()
        int32_t getChannelCountBase()

        #ICollection<SignalDrop>* getConvertClockSources()
        #MathInterval getConvertClockRange()

        libcpp.bool getBurstScanSupported()
        #ICollection<SignalDrop>* getScanClockSources()
        #MathInterval getScanClockRange()
        int32_t getScanCountMax()

        libcpp.bool getTriggerSupported()
        int32_t getTriggerCount()
        #ICollection<SignalDrop>* getTriggerSources()
        #ICollection<TriggerAction>* getTriggerActions()
        #MathInterval getTriggerDelayRange()

        libcpp.bool getTrigger1Supported()
        #ICollection<SignalDrop>*    getTrigger1Sources()
        #ICollection<TriggerAction>* getTrigger1Actions()
        #MathInterval getTrigger1DelayRange()

    cppclass AiCtrlBase(DeviceCtrlBase):
        AiFeatures* getFeatures()
        #AiChannelCollection* getChannels()
        int32_t getChannelCount()

    cppclass InstantAiCtrl(AiCtrlBase):
        ErrorCode ReadAny(libc.stdint.int32_t chStart, libc.stdint.int32_t chCount, void* dataRaw, double* dataScaled)
        #CjcSetting* getCjc()
        ErrorCode Read(int32_t ch, double& dataScaled)
        ErrorCode Read(int32_t ch, int16_t& dataRaw)
        ErrorCode Read(int32_t ch, int32_t& dataRaw)
        ErrorCode Read(int32_t chStart, int32_t chCount, double* dataScaled)
        ErrorCode Read(int32_t chStart, int32_t chCount, int16_t* dataRaw, double* dataScaled)
        ErrorCode Read(int32_t chStart, int32_t chCount, int32_t* dataRaw, double* dataScaled)

    #
    # DIGITAL I/O
    #

    cppclass DioFeatures:
        libcpp.bool getPortProgrammable()
        int32_t getPortCount()
        #ICollection<uint8>* getPortsType()
        libcpp.bool getDiSupported()
        libcpp.bool getDoSupported()

        int32_t getChannelCountMax()

    cppclass DioCtrlBase(DeviceCtrlBase):
        int32_t getPortCount()
        #ICollection<PortDirection>* getPortDirection()

    cppclass DoFeatures(DioFeatures):
        #virtual ICollection<uint8>*         BDAQCALL getDataMask() = 0;

        #virtual ICollection<SignalDrop>*    BDAQCALL getDoFreezeSignalSources() = 0;

        #virtual MathInterval                BDAQCALL getDoReflectWdtFeedIntervalRange() = 0;

        libcpp.bool getBufferedDoSupported()
        #virtual SamplingMethod              BDAQCALL getSamplingMethod() = 0;

        #virtual ICollection<SignalDrop>*    BDAQCALL getConvertClockSources() = 0;
        #virtual MathInterval                BDAQCALL getConvertClockRange() = 0;

        libcpp.bool getBurstScanSupported()
        #virtual ICollection<SignalDrop>*    BDAQCALL getScanClockSources() = 0;
        #virtual MathInterval                BDAQCALL getScanClockRange() = 0;
        int32_t getScanCountMax()

        libcpp.bool getTriggerSupported()
        int32_t getTriggerCount()
        #virtual ICollection<SignalDrop>*    BDAQCALL getTriggerSources() = 0;
        #virtual ICollection<TriggerAction>* BDAQCALL getTriggerActions() = 0;
        #virtual MathInterval                BDAQCALL getTriggerDelayRange() = 0;

    cppclass DoCtrlBase(DioCtrlBase):
        DoFeatures* getFeatures()

    cppclass InstantDoCtrl(DoCtrlBase):
        ErrorCode WriteAny(int32_t portStart, int32_t portCount, uint8_t* data)
        ErrorCode ReadAny(int32_t portStart, int32_t portCount, uint8_t* data)

        ErrorCode Write(int32_t port, uint8_t data)
        ErrorCode Write(int32_t portStart, int32_t portCount, uint8_t* data)
        ErrorCode Read(int32_t port, uint8_t& data)
        ErrorCode Read(int32_t portStart, int32_t portCount, uint8_t* data)

    #
    # OBJECT CREATION
    #

    InstantAiCtrl* AdxInstantAiCtrlCreate()
    #BufferedAiCtrl* AdxBufferedAiCtrlCreate()
    #InstantAoCtrl* AdxInstantAoCtrlCreate()
    #BufferedAoCtrl* AdxBufferedAoCtrlCreate()
    #InstantDiCtrl* AdxInstantDiCtrlCreate()
    #BufferedDiCtrl* AdxBufferedDiCtrlCreate()
    InstantDoCtrl* AdxInstantDoCtrlCreate()
    #BufferedDoCtrl* AdxBufferedDoCtrlCreate()
    #EventCounterCtrl* AdxEventCounterCtrlCreate()
    #FreqMeterCtrl* AdxFreqMeterCtrlCreate()
    #OneShotCtrl* AdxOneShotCtrlCreate()
    #PwMeterCtrl* AdxPwMeterCtrlCreate()
    #PwModulatorCtrl* AdxPwModulatorCtrlCreate()
    #TimerPulseCtrl* AdxTimerPulseCtrlCreate()
    #UdCounterCtrl* AdxUdCounterCtrlCreate()
