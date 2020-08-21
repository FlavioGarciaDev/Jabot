[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

function Toast-Titulo-Imagem{
    param($Titulo, $Imagem)
    process{

$Template = 
@"
<toast>
    <visual>
        <binding template="ToastImageAndText01">
            <text id='1'>$($Titulo)</text>
            <image id='1' placement="appLogoOverride" src='$($Imagem)'/>
        </binding>
    </visual>
</toast>
"@

        $XML = New-Object Windows.Data.Xml.Dom.XmlDocument
        $XML.LoadXml($Template)
        $Toast = New-Object Windows.UI.Notifications.ToastNotification $XML
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppSettings.AppId).Show($Toast)
    }
}

function Inicia-Alerta-TFS {
process{

        Start-Job -ScriptBlock {

            [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

            $AppSettings = $args[0]

            # Períodos
            $MomentoNotificacaoDT = [DateTime]$AppSettings.JabotINI.TFS.Horario
            $IntervaloVerificacao =[Int]$AppSettings.JabotINI.Dados.Intervalo

            While ($TRUE){
                $Hoje = Get-Date

                if($Hoje.Hour -eq $MomentoNotificacaoDT.Hour -and $Hoje.Minute -eq $MomentoNotificacaoDT.Minute){

                    # Mensagens
                    $ArrayMensagens = Get-Content -Path $AppSettings.ArquivoFrasesTFS -Encoding UTF8

                    # Imagens
                    $ArrayImagensPerfil = (Get-ChildItem -Path $AppSettings.DirImagensPerfil).FullName | %{$_}

                    # Sons de Alertas
                    $ArrayAlertas = Get-Content -Path $AppSettings.ArquivoAlertas -Encoding UTF8
      
                    # Sorteando
                    $PosicaoFrase = Get-Random -Maximum $ArrayMensagens.Count
                    $PosicaoImagem = Get-Random -Maximum $ArrayImagensPerfil.Count
                    $PosicaoAlerta = Get-Random -Maximum $ArrayAlertas.Count

                    $Titulo = $($ArrayMensagens[$PosicaoFrase] + "`n")
                    $Imagem = $($ArrayImagensPerfil[$PosicaoImagem])
                    $Som = $($ArrayAlertas[$PosicaoAlerta])

                    $Template = 
@"
<toast scenario="reminder" launch='$($AppSettings.JabotINI.TFS.URL)' activationType='protocol'>
  
    <visual>
    <binding template='ToastGeneric'>
        <text>$($Titulo)</text>
        <image placement="appLogoOverride" src='$($Imagem)'/>
    </binding>
    </visual>

    <audio src= '$($Som)' loop='true' />

    <actions>
        <input title="Me lembrar em:" id="soneca" type="selection" defaultInput="15">
            <selection id="5" content="5 minutos"/>
            <selection id="10" content="10 minutos"/>
            <selection id="15" content="15 minutos"/>
            <selection id="30" content="30 minutos"/>
            <selection id="60" content="1 hora"/>
        </input>
      
        <action
            activationType="system"
            arguments="dismiss"
            content="Já sim!"
            imageUri="$($AppSettings.ImgBotaoConfirma)"/>

        <action
            activationType="system"
            arguments="snooze"
            hint-inputId="soneca"
            content="Daqui a pouco..."
            imageUri="$($AppSettings.ImgBotaoSoneca)"/>
    
    </actions>
  
</toast>
"@
                    $XML = New-Object Windows.Data.Xml.Dom.XmlDocument
                    $XML.LoadXml($Template)
                    $Toast = New-Object Windows.UI.Notifications.ToastNotification $XML
                    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppSettings.AppId).Show($Toast)
        
                }

                Sleep -Seconds $IntervaloVerificacao
            }

        } -ArgumentList $AppSettings
    }

}

function Inicia-Alerta-Netsuite {
process{

        Start-Job -ScriptBlock {

            [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

            $AppSettings = $args[0]
            $Domingo = 0
            $Segunda = 1
            $Sabado = 6

            # Períodos
            $MomentoNotificacaoDT = [DateTime]$AppSettings.JabotINI.Netsuite.Horario
            $IntervaloVerificacao = [Int]$AppSettings.JabotINI.Dados.Intervalo

            While ($TRUE){
                $Hoje = Get-Date

                if($Hoje.DayOfWeek.value__ -eq $Segunda -or ($Hoje.Day -eq 1 -and ($Hoje.DayOfWeek.value__ -ne $Segunda -and $Hoje.DayOfWeek.value__ -ne $Domingo -and $Hoje.DayOfWeek.value__ -ne $Sabado))){

                    if($Hoje.Hour -eq $MomentoNotificacaoDT.Hour -and $Hoje.Minute -eq $MomentoNotificacaoDT.Minute){

                        # Mensagens
                        $ArrayMensagens = Get-Content -Path $AppSettings.ArquivoFrasesNetsuite -Encoding UTF8

                        # Imagens
                        $ArrayImagensPerfil = (Get-ChildItem -Path $AppSettings.DirImagensPerfil).FullName | %{$_}

                        # Sons de Alertas
                        $ArrayAlertas = Get-Content -Path $AppSettings.ArquivoAlertas -Encoding UTF8
      
                        # Sorteando
                        $PosicaoFrase = Get-Random -Maximum $ArrayMensagens.Count
                        $PosicaoImagem = Get-Random -Maximum $ArrayImagensPerfil.Count
                        $PosicaoAlerta = Get-Random -Maximum $ArrayAlertas.Count

                        $Titulo = $($ArrayMensagens[$PosicaoFrase] + "`n")
                        $Imagem = $($ArrayImagensPerfil[$PosicaoImagem])
                        $Som = $($ArrayAlertas[$PosicaoAlerta])

                        $Template = 
@"
<toast scenario="reminder" launch='$($AppSettings.JabotINI.Netsuite.URL)' activationType='protocol'>
  
    <visual>
    <binding template='ToastGeneric'>
        <text>$($Titulo)</text>
        <image placement="appLogoOverride" src='$($Imagem)'/>
    </binding>
    </visual>

    <audio src= '$($Som)' loop='true' />

    <actions>
        <input title="Me lembrar em:" id="soneca" type="selection" defaultInput="15">
            <selection id="5" content="5 minutos"/>
            <selection id="10" content="10 minutos"/>
            <selection id="15" content="15 minutos"/>
            <selection id="30" content="30 minutos"/>
            <selection id="60" content="1 hora"/>
        </input>
      
        <action
            activationType="system"
            arguments="dismiss"
            content="Já lancei!"
            imageUri="$($AppSettings.ImgBotaoConfirma)"/>

        <action
            activationType="system"
            arguments="snooze"
            hint-inputId="soneca"
            content="Agora não..."
            imageUri="$($AppSettings.ImgBotaoSoneca)"/>
    
    </actions>
  
</toast>
"@
                        $XML = New-Object Windows.Data.Xml.Dom.XmlDocument
                        $XML.LoadXml($Template)
                        $Toast = New-Object Windows.UI.Notifications.ToastNotification $XML
                        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppSettings.AppId).Show($Toast)
        
                    }
                }

                Sleep -Seconds $IntervaloVerificacao
            }

        } -ArgumentList $AppSettings
    }

}

function Inicia-Alerta-FolhaPonto {
process{

        Start-Job -ScriptBlock {

            [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

            $AppSettings = $args[0]

            # Períodos
            $MomentoNotificacaoDT = [DateTime]$AppSettings.JabotINI.FolhaPonto.Horario
            $IntervaloVerificacao = [Int]$AppSettings.JabotINI.Dados.Intervalo

            While ($TRUE){
                $Hoje = Get-Date

                $DiasNoMes = [System.DateTime]::DaysInMonth($Hoje.Year, $Hoje.Month)
                $UltimoDiaMes = Get-Date -Year $Hoje.Year -Month $Hoje.Month -Day $DiasNoMes -Hour 0 -Minute 0 -Second 0 -Millisecond 0
                
                switch ($UltimoDiaMes.DayOfWeek)
                {
                    ([System.DayOfWeek]::Sunday)   { $UltimoDiaMes = $UltimoDiaMes.AddDays(-2) }
                    ([System.DayOfWeek]::Saturday) { $UltimoDiaMes = $UltimoDiaMes.AddDays(-1) }
                    default {}
                }

                if ($Hoje.Day -eq $UltimoDiaMes.Day){

                    if($Hoje.Hour -eq $MomentoNotificacaoDT.Hour -and $Hoje.Minute -eq $MomentoNotificacaoDT.Minute){

                        # Mensagens
                        $ArrayMensagens = Get-Content -Path $AppSettings.ArquivoFrasesFolhaPonto -Encoding UTF8

                        # Imagens
                        $ArrayImagensPerfil = (Get-ChildItem -Path $AppSettings.DirImagensPerfil).FullName | %{$_}

                        # Sons de Alertas
                        $ArrayAlertas = Get-Content -Path $AppSettings.ArquivoAlertas -Encoding UTF8
      
                        # Sorteando
                        $PosicaoFrase = Get-Random -Maximum $ArrayMensagens.Count
                        $PosicaoImagem = Get-Random -Maximum $ArrayImagensPerfil.Count
                        $PosicaoAlerta = Get-Random -Maximum $ArrayAlertas.Count

                        $Titulo = $($ArrayMensagens[$PosicaoFrase] + "`n")
                        $Imagem = $($ArrayImagensPerfil[$PosicaoImagem])
                        $Som = $($ArrayAlertas[$PosicaoAlerta])

                        $Template =
@"
<toast scenario="reminder" launch='$($AppSettings.JabotINI.FolhaPonto.URL)' activationType='protocol'>
  
    <visual>
    <binding template='ToastGeneric'>
        <text>$($Titulo)</text>
        <image placement="appLogoOverride" src='$($Imagem)'/>
    </binding>
    </visual>

    <audio src= '$($Som)' loop='true' />

    <actions>
        <input title="Me lembrar em:" id="soneca" type="selection" defaultInput="15">
            <selection id="5" content="5 minutos"/>
            <selection id="10" content="10 minutos"/>
            <selection id="15" content="15 minutos"/>
            <selection id="30" content="30 minutos"/>
            <selection id="60" content="1 hora"/>
        </input>
      
        <action
            activationType="system"
            arguments="dismiss"
            content="Já fiz!"
            imageUri="$($AppSettings.ImgBotaoConfirma)"/>

        <action
            activationType="system"
            arguments="snooze"
            hint-inputId="soneca"
            content="Pera aí..."
            imageUri="$($AppSettings.ImgBotaoSoneca)"/>
    
    </actions>
  
</toast>
"@
                        $XML = New-Object Windows.Data.Xml.Dom.XmlDocument
                        $XML.LoadXml($Template)
                        $Toast = New-Object Windows.UI.Notifications.ToastNotification $XML
                        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppSettings.AppId).Show($Toast)
        
                    }
                }
                Sleep -Seconds $IntervaloVerificacao
            }

        } -ArgumentList $AppSettings
    }

}

function Inicia-Alerta-Cerveja {
process{

        Start-Job -ScriptBlock {

            [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

            $AppSettings = $args[0]
            $Sexta = 5

            # Períodos
            $MomentoNotificacaoDT = [DateTime]$AppSettings.JabotINI.Cerveja.Horario
            $IntervaloVerificacao = [Int]$AppSettings.JabotINI.Dados.Intervalo

            While ($TRUE){
                $Hoje = Get-Date

                if ($Hoje.DayOfWeek.value__ -eq $Sexta){

                    if($Hoje.Hour -eq $MomentoNotificacaoDT.Hour -and $Hoje.Minute -eq $MomentoNotificacaoDT.Minute){

                        # Mensagens
                        $ArrayMensagens = Get-Content -Path $AppSettings.ArquivoFrasesCerveja -Encoding UTF8

                        # Imagens
                        $ArrayImagensPerfil = (Get-ChildItem -Path $AppSettings.DirImagensPerfil).FullName | %{$_}
                        $ArrayImagensBanner = (Get-ChildItem -Path $AppSettings.DirImagensBanner).FullName | %{$_}
      
                        # Sorteando
                        $PosicaoFrase = Get-Random -Maximum $ArrayMensagens.Count
                        $PosicaoImagem = Get-Random -Maximum $ArrayImagensPerfil.Count
                        $PosicaoBanner = Get-Random -Maximum $ArrayImagensBanner.Count

                        $Titulo = $($ArrayMensagens[$PosicaoFrase] + "`n")
                        $Imagem = $($ArrayImagensPerfil[$PosicaoImagem])
                        $Banner = $($ArrayImagensBanner[$PosicaoBanner])

                        $Template = 
@"
<toast scenario="reminder" launch='$($AppSettings.JabotINI.Cerveja.URL)' activationType='protocol'>
  
    <visual>
    <binding template='ToastGeneric'>
        <text>$($Titulo)</text>
        <image placement="appLogoOverride" src='$($Imagem)'/>
        <image placement="hero" src="$($Banner)"/>
    </binding>
    </visual>
  
</toast>
"@
                        $XML = New-Object Windows.Data.Xml.Dom.XmlDocument
                        $XML.LoadXml($Template)
                        $Toast = New-Object Windows.UI.Notifications.ToastNotification $XML
                        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppSettings.AppId).Show($Toast)
        
                    }

                }

                Sleep -Seconds $IntervaloVerificacao
            }

        } -ArgumentList $AppSettings
    }

}

function Inicia-Alerta-Aleatorio {
process{

        Start-Job -ScriptBlock {

            [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
            [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

            $AppSettings = $args[0]

            # Períodos
            $IntervaloVerificacao = [Int]$AppSettings.JabotINI.Diversos.Intervalo
            $Probabilidade = [Int]$AppSettings.JabotINI.Diversos.Probabilidade

            While ($TRUE){
                $Chance = Get-Random -Maximum $Probabilidade

                if($Chance -eq 1){

                    # Mensagens
                    $ArrayMensagens = Get-Content -Path $AppSettings.ArquivoFrasesDiversos -Encoding UTF8

                    # Imagens
                    $ArrayImagensPerfil = (Get-ChildItem -Path $AppSettings.DirImagensPerfil).FullName | %{$_}

                    # Sons de Alertas
                    $ArrayAlertas = Get-Content -Path $AppSettings.ArquivoAlertas -Encoding UTF8
      
                    # Sorteando
                    $PosicaoFrase = Get-Random -Maximum $ArrayMensagens.Count
                    $PosicaoImagem = Get-Random -Maximum $ArrayImagensPerfil.Count
                    $PosicaoAlerta = Get-Random -Maximum $ArrayAlertas.Count

                    $Titulo = $($ArrayMensagens[$PosicaoFrase] + "`n")
                    $Imagem = $($ArrayImagensPerfil[$PosicaoImagem])
                    $Som = $($ArrayAlertas[$PosicaoAlerta])

                    $Template = 
@"
<toast scenario="reminder" launch='$($AppSettings.JabotINI.Diversos.URL)' activationType='protocol'>
  
  <header id='1' title='Lembrete pra você que é lento!' arguments=''/>

    <visual>
    <binding template='ToastGeneric'>
        <text>$($Titulo)</text>
        <image placement="appLogoOverride" src='$($Imagem)'/>
    </binding>
    </visual>

    <audio src= '$($Som)' loop='true' />

    <actions>
        <input title="Me lembrar em:" id="soneca" type="selection" defaultInput="15">
            <selection id="5" content="5 minutos"/>
            <selection id="10" content="10 minutos"/>
            <selection id="15" content="15 minutos"/>
            <selection id="30" content="30 minutos"/>
            <selection id="60" content="1 hora"/>
        </input>
      
        <action
            activationType="system"
            arguments="dismiss"
            content="Não me enche..."
            imageUri="$($AppSettings.ImgBotaoConfirma)"/>

        <action
            activationType="system"
            arguments="snooze"
            hint-inputId="soneca"
            content="Calma aí..."
            imageUri="$($AppSettings.ImgBotaoSoneca)"/>
    
    </actions>
  
</toast>
"@
                    $XML = New-Object Windows.Data.Xml.Dom.XmlDocument
                    $XML.LoadXml($Template)
                    $Toast = New-Object Windows.UI.Notifications.ToastNotification $XML
                    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppSettings.AppId).Show($Toast)

                    Sleep -Seconds 10800
        
                }

                Sleep -Seconds $IntervaloVerificacao
            }

        } -ArgumentList $AppSettings
    }

}