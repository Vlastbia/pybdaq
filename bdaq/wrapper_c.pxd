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

    cppclass CjcSetting:
        int32_t getChannel()
        enums_c.ErrorCode setChannel(int32_t ch)
        double getValue()
        enums_c.ErrorCode setValue(double value)

    cppclass MathInterval:
        libc.stdint.int32_t Type
        double Min
        double Max
        
    cppclass DiintChannel:
        int32_t getChannel()
        libcpp.bool getEnabled()
        enums_c.ErrorCode setEnabled(libcpp.bool value)
        libcpp.bool getGated()
        enums_c.ErrorCode setGated(libcpp.bool value)
        enums_c.ActiveSignal getTrigEdge()
        enums_c.ErrorCode setTrigEdge(enums_c.ActiveSignal value)

    cppclass DiCosintPort:
        int32_t getPort()
        uint8_t getMask()
        enums_c.ErrorCode setMask(uint8_t value)

    cppclass DiPmintPort:
        int32_t getPort()
        uint8_t getMask()
        enums_c.ErrorCode setMask(uint8_t value)
        uint8_t getPattern()
        enums_c.ErrorCode setPattern(uint8_t value)

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

    cppclass DeviceInformation:
        int32_t DeviceNumber
        enums_c.AccessMode DeviceMode
        int32_t ModuleIndex
        libc.stddef.wchar_t Description[MAX_DEVICE_DESC_LEN]

        DeviceInformation()
        DeviceInformation(
            int32_t deviceNumber,
            enums_c.AccessMode mode,
            int32_t moduleIndex)
        DeviceInformation(
            libc.stddef.wchar_t* deviceDesc,
            enums_c.AccessMode mode,
            int32_t moduleIndex)
        void Init(
            int32_t deviceNumber,
            libc.stddef.wchar_t* deviceDesc,
            enums_c.AccessMode mode,
            int32_t moduleIndex)

    #enums_c.ErrorCode AdxDeviceGetLinkageInfo(
        #int32 deviceParent,
        #int32 index,
        #int32* deviceNumber,
        #wchar_t* description,
        #int32* subDeviceCount)

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
        #virtual ICollection<DeviceTreeNode>* BDAQCALL getSupportedDevices() = 0;
        #virtual ICollection<enums_c.AccessMode>*     BDAQCALL getSupportedModes() = 0;

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

        #ICollection<SignalDrop>* getConvertClockSources()
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
        #AiChannelCollection* getChannels()
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
        
    cppclass DiFeatures(DioFeatures):
        ICollection[uint8_t]* getDataMask()

#      // di noise filter features
        libcpp.bool getNoiseFilterSupported()
        ICollection[uint8_t]* getNoiseFilterOfChannels()
        MathInterval getNoiseFilterBlockTimeRange()
#
#      // di interrupt features
        libcpp.bool getDiintSupported()
        libcpp.bool getDiintGateSupported()
        libcpp.bool getDiCosintSupported()
        libcpp.bool getDiPmintSupported()
        ICollection[enums_c.ActiveSignal]*  getDiintTriggerEdges()
        ICollection[uint8_t]* getDiintOfChannels()
        ICollection[uint8_t]* getDiintGateOfChannels()
        ICollection[uint8_t]* getDiCosintOfPorts()
        ICollection[uint8_t]* getDiPmintOfPorts()
        ICollection[int32_t]* getSnapEventSources()
#
#      // buffered di->basic features
        libcpp.bool getBufferedDiSupported()
        enums_c.SamplingMethod getSamplingMethod()
#
#      // buffered di->conversion clock features
#      virtual ICollection<SignalDrop>*    BDAQCALL getConvertClockSources() = 0;
        MathInterval getConvertClockRange()
#
#      // buffered di->burst scan
        libcpp.bool getBurstScanSupported()
#      virtual ICollection<SignalDrop>*    BDAQCALL getScanClockSources() = 0;
        MathInterval getScanClockRange()
        int32_t getScanCountMax()
#
#      // buffered di->trigger features
        libcpp.bool getTriggerSupported()
        int32_t getTriggerCount()
#      virtual ICollection<SignalDrop>*    BDAQCALL getTriggerSources() = 0;
#      virtual ICollection<TriggerAction>* BDAQCALL getTriggerActions() = 0;
        MathInterval getTriggerDelayRange()
        
    cppclass DiCtrlBase(DioCtrlBase):
        DiFeatures* getFeatures()
        
    cppclass InstantDiCtrl(DiCtrlBase):
        enums_c.ErrorCode ReadAny(int32_t portStart, int32_t portCount, uint8_t* data)

        enums_c.ErrorCode Read(int32_t port, uint8_t& data)
        enums_c.ErrorCode Read(int32_t portStart, int32_t portCount, uint8_t* data)
        
        enums_c.ErrorCode SnapStart()
        enums_c.ErrorCode SnapStop()
        
        ICollection[DiintChannel]* getDiintChannels()
        ICollection[DiCosintPort]* getDiCosintPorts()
        ICollection[DiPmintPort]* getDiPmintPorts()
        
        enums_c.ErrorCode ReadBit(int32_t portStart, int32_t bit, uint8_t* data)
        
    cppclass DoFeatures(DioFeatures):
        ICollection[uint8_t]* getDataMask()
        #virtual ICollection<SignalDrop>*    BDAQCALL getDoFreezeSignalSources() = 0;
        MathInterval getDoReflectWdtFeedIntervalRange()
        libcpp.bool getBufferedDoSupported()
        enums_c.SamplingMethod getSamplingMethod()
        #virtual ICollection<SignalDrop>*    BDAQCALL getConvertClockSources() = 0;
        MathInterval getConvertClockRange()
        libcpp.bool getBurstScanSupported()
        #virtual ICollection<SignalDrop>*    BDAQCALL getScanClockSources() = 0;
        MathInterval getScanClockRange()
        int32_t getScanCountMax()
        libcpp.bool getTriggerSupported()
        int32_t getTriggerCount()
        #virtual ICollection<SignalDrop>*    BDAQCALL getTriggerSources() = 0;
        #virtual ICollection<TriggerAction>* BDAQCALL getTriggerActions() = 0;
        MathInterval getTriggerDelayRange()

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
    InstantDiCtrl* AdxInstantDiCtrlCreate()
#    BufferedDiCtrl* AdxBufferedDiCtrlCreate()
    InstantDoCtrl* AdxInstantDoCtrlCreate()
    #BufferedDoCtrl* AdxBufferedDoCtrlCreate()
    #EventCounterCtrl* AdxEventCounterCtrlCreate()
    #FreqMeterCtrl* AdxFreqMeterCtrlCreate()
    #OneShotCtrl* AdxOneShotCtrlCreate()
    #PwMeterCtrl* AdxPwMeterCtrlCreate()
    #PwModulatorCtrl* AdxPwModulatorCtrlCreate()
    #TimerPulseCtrl* AdxTimerPulseCtrlCreate()
    #UdCounterCtrl* AdxUdCounterCtrlCreate()
