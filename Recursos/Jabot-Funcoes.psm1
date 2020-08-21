function Inicia-Para-Notificacoes{
    param($MenuParaInicia)
    process{

        if((Get-Job).Count -gt 0)
        {
            # Removendo os alertas iniciados
            Get-Job | Remove-Job -Force

            $MenuParaInicia.Image = [System.Drawing.Bitmap]::FromFile($AppSettings.ImgMenuPlay)
            $MenuParaInicia.Text = "Iniciar Monitoramento"

            $ObjetoJabot.Text = $AppSettings.NotificacoesInativo
            $ObjetoJabot.Icon = $AppSettings.IcoPeixeOFF

            Toast-Titulo-Imagem -Titulo "Quer nadar sozinho então? Não me decepcione..." -Imagem $AppSettings.PeixeOFF
        }
        else
        {
            Inicia-Alertas

            $MenuParaInicia.Image = [System.Drawing.Bitmap]::FromFile($AppSettings.ImgMenuStop)
            $MenuParaInicia.Text = "Desativar Notificações"

            $ObjetoJabot.Text = $AppSettings.NotificacoesAtivo
            $ObjetoJabot.Icon = $AppSettings.IcoPeixeON

            Toast-Titulo-Imagem -Titulo "Deixa com o peixe aqui, vou te lembrar de tudo!" -Imagem $AppSettings.PeixeON          
        }
    }
}

function Atualiza-Credenciais-BS2{
    param()
    process{
        [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

        $BSI = $AppSettings.JabotINI.Dados.LoginBS2
        $Senha = [Microsoft.VisualBasic.Interaction]::InputBox("Nova senha:", "Alteração de senha BS2")

        if($Senha.Trim() -eq "" -or $Senha -eq $null)
        {
            [System.Windows.MessageBox]::Show("Tem que digitar alguma coisa né?","Aí não meu amigo",[System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning)
            return
        }

        if(!$(Get-Module -ListAvailable "CredentialManager"))
        {
            Install-Module CredentialManager -Force
        }

        $ListaCredenciais = Get-StoredCredential -AsCredentialObject
        $ListaCredenciais | Where-Object {$_.UserName -match "$BSI|bonsucesso|bs2"} |  ForEach-Object {
            $Usuario = $_.Username
            $Target = $_.TargetName.Split("=")[1]
            $Argument = "/add:$($Target) /user:$($Usuario) /pass:$($Senha)"
            Start-Process Cmdkey -ArgumentList $Argument -NoNewWindow -RedirectStandardOutput $False
    
            #New-StoredCredential -Target $Target -UserName $Usuario -Password $Senha

        }

    }
}

 function Inicia-Alertas {
    param()
    process
    {  
        Inicia-Alerta-TFS
        Inicia-Alerta-Netsuite
        Inicia-Alerta-FolhaPonto
        Inicia-Alerta-Cerveja
        Inicia-Alerta-Aleatorio
    }
}

# Retorna último dia útil do mês atual
function Ultimo-DiaUtil {

    param(
        $ano  = [System.DateTime]::Now.Year,
        $mes = [System.DateTime]::Now.Month
    )

    $DiasNoMes = [System.DateTime]::DaysInMonth($ano, $mes)

    $UltimoDiaMes = Get-Date -Year $ano -Month $mes -Day $DiasNoMes -Hour 0 -Minute 0 -Second 0 -Millisecond 0

    switch ($DiasNoMes.DayOfWeek)
    {
        ([System.DayOfWeek]::Sunday)   { $UltimoDiaMes.AddDays(-2) }
        ([System.DayOfWeek]::Saturday) { $UltimoDiaMes.AddDays(-1) }
        default { $UltimoDiaMes }
    }
}

function Encerra-Jabot {
    param()
    process{

    # Removendo os Jobs criados 
    Get-Job | Remove-Job -Force

    Get-Module -Name "Jabot-*" | Remove-Module -Force

    # Fechando a aplicação
    [System.Windows.Forms.Application]::Exit()

    # Libera os recursos que foram instanciados com o Dispose
    Get-Variable -exclude Runspace -ErrorAction SilentlyContinue |
            Where-Object {
                $_.Value -is [System.IDisposable]
            } |
            Foreach-Object {
                $_.Value.Dispose()
                Remove-Variable $_.Name
        }

    # Encerra tudo do Powershell
    Get-Process -ProcessName "powershell" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

     }
 }

# Verifica se está rodando como administrador
function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}