cimport libc.stdint
cimport libc.stddef
cimport libcpp
cimport bdaq.wrapper_enums_c as enums_c

from libc.stdint cimport (
    uint8_t,
    int16_t,
    int32_t)
from libc.stddef cimport wchar_t


cdef extern from "bdaqctrl.h" namespace "Automation::BDaq":
    cppclass ICollection[T]:
        void Dispose()
        int32_t getCount()
        T& getItem(int32_t index)

    cppclass MathInterval:
        libc.stdint.int32_t Type
        double Min
        double Max

    enums_c.ErrorCode AdxEnumToString(
        wchar_t* enumTypeName,
        int32_t enumValue,
        int32_t enumStringLength,
        wchar_t* enumString)

    enums_c.ErrorCode AdxStringToEnum(
        wchar_t* enumTypeName,
        wchar_t* enumString,
        int32_t* enumValue)

    enum:
        MAX_DEVICE_DESC_LEN

    cppclass AnalogChannel:
        int32_t getChannel()
        enums_c.ValueRange getValueRange()
        enums_c.ErrorCode setValueRange(enums_c.ValueRange value)

    cppclass AnalogInputChannel(AnalogChannel):
        enums_c.AiSignalType getSignalType()
        enums_c.ErrorCode setSignalType(enums_c.AiSignalType value)
        enums_c.BurnoutRetType getBurnoutRetType()
        enums_c.ErrorCode setBurnoutRetType(enums_c.BurnoutRetType value)
        double getBurnoutRetValue()
        enums_c.ErrorCode setBurnoutRetValue(double value)

    cppclass CjcSetting:
        int32_t getChannel()
        enums_c.ErrorCode setChannel(int32_t ch)
        double getValue()
        enums_c.ErrorCode setValue(double value)

    cppclass DeviceInformation:
        libc.stdint.int32_t DeviceNumber
        enums_c.AccessMode DeviceMode
        libc.stdint.int32_t ModuleIndex
        libc.stddef.wchar_t Description[MAX_DEVICE_DESC_LEN]

        DeviceInformation()
        DeviceInformation(
            libc.stdint.int32_t deviceNumber,
            enums_c.AccessMode mode,
            libc.stdint.int32_t moduleIndex)
        DeviceInformation(
            libc.stddef.wchar_t* deviceDesc,
            enums_c.AccessMode mode,
            libc.stdint.int32_t moduleIndex)
        void Init(
            libc.stdint.int32_t deviceNumber,
            libc.stddef.wchar_t* deviceDesc,
            enums_c.AccessMode mode,
            libc.stdint.int32_t moduleIndex)

    #enums_c.ErrorCode AdxGetValueRangeInformation(
        #ValueRange   type,         /*IN*/
        #int32        descBufSize,  /*IN*/
        #wchar_t      *description, /*OUT OPTIONAL*/
        #MathInterval *range,       /*OUT OPTIONAL*/
        #ValueUnit    *unit);        /*OUT OPTIONAL */

    #enums_c.ErrorCode AdxGetSignalConnectionInformation(
        #SignalDrop     signal,      /*IN*/
        #int32          descBufSize, /*IN*/
        #wchar_t        *description,/*OUT OPTIONAL*/
        #SignalPosition *position);   /*OUT OPTIONAL*/

    cppclass DeviceCtrlBase:
        void Dispose()
        void Cleanup()
        enums_c.ErrorCode UpdateProperties()

        #void addRemovedListener(DeviceEventListener& listener)
        #void removeRemovedListener(DeviceEventListener& listener)
        #void addReconnectedListener(DeviceEventListener& listener)
        #void removeReconnectedListener(DeviceEventListener& listener)
        #void addPropertyChangedListener(DeviceEventListener& listener)
        #void removePropertyChangedListener(DeviceEventListener& listener)

        void getSelectedDevice(DeviceInformation& x)
        enums_c.ErrorCode setSelectedDevice(DeviceInformation& x)
        libcpp.bool getInitialized()
        libcpp.bool getCanEditProperty()
        void* getDevice()
        void* getModule()
        #ICollection<DeviceTreeNode>* getSupportedDevices()
        #ICollection<enums_c.AccessMode>* getSupportedModes()

    #
    # ANALOG INPUT
    #

    cppclass AiFeatures:
        int32_t getResolution()
        int32_t getDataSize()
        int32_t getDataMask()

        int32_t getChannelCountMax()
        enums_c.AiChannelType getChannelType()
        libcpp.bool getOverallValueRange()
        libcpp.bool getThermoSupported()
        ICollection[enums_c.ValueRange]* getValueRanges()
        ICollection[enums_c.BurnoutRetType]* getBurnoutReturnTypes()

        ICollection[int32_t]* getCjcChannels()

        libcpp.bool getBufferedAiSupported()
        enums_c.SamplingMethod getSamplingMethod()
        int32_t getChannelStartBase()
        int32_t getChannelCountBase()

        ICollection[enums_c.SignalDrop]* getConvertClockSources()
        MathInterval getConvertClockRange()

        libcpp.bool getBurstScanSupported()
        #ICollection<SignalDrop>* getScanClockSources()
        MathInterval getScanClockRange()
        int32_t getScanCountMax()

        libcpp.bool getTriggerSupported()
        int32_t getTriggerCount()
        #ICollection<SignalDrop>* getTriggerSources()
        #ICollection<TriggerAction>* getTriggerActions()
        MathInterval getTriggerDelayRange()

        libcpp.bool getTrigger1Supported()
        #ICollection<SignalDrop>*    getTrigger1Sources()
        #ICollection<TriggerAction>* getTrigger1Actions()
        MathInterval getTrigger1DelayRange()

    cppclass AiCtrlBase(DeviceCtrlBase):
        AiFeatures* getFeatures()
        ICollection[AnalogInputChannel]* getChannels()
        int32_t getChannelCount()

    cppclass InstantAiCtrl(AiCtrlBase):
        enums_c.ErrorCode ReadAny(libc.stdint.int32_t chStart, libc.stdint.int32_t chCount, void* dataRaw, double* dataScaled)
        CjcSetting* getCjc()
        enums_c.ErrorCode Read(int32_t ch, double& dataScaled)
        enums_c.ErrorCode Read(int32_t ch, int16_t& dataRaw)
        enums_c.ErrorCode Read(int32_t ch, int32_t& dataRaw)
        enums_c.ErrorCode Read(int32_t chStart, int32_t chCount, double* dataScaled)
        enums_c.ErrorCode Read(int32_t chStart, int32_t chCount, int16_t* dataRaw, double* dataScaled)
        enums_c.ErrorCode Read(int32_t chStart, int32_t chCount, int32_t* dataRaw, double* dataScaled)

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
        enums_c.ErrorCode WriteAny(int32_t portStart, int32_t portCount, uint8_t* data)
        enums_c.ErrorCode ReadAny(int32_t portStart, int32_t portCount, uint8_t* data)

        enums_c.ErrorCode Write(int32_t port, uint8_t data)
        enums_c.ErrorCode Write(int32_t portStart, int32_t portCount, uint8_t* data)
        enums_c.ErrorCode Read(int32_t port, uint8_t& data)
        enums_c.ErrorCode Read(int32_t portStart, int32_t portCount, uint8_t* data)

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
