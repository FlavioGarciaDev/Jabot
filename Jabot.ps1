[hashtable]$AppSettings = @{}
$AppSettings.Add('AppId','Jabot® 2.3')

$DirModulos = "$PSScriptRoot\Recursos"

if(!$(Get-Module -ListAvailable "PsIni"))
{
    Install-Module PsIni -Force
}

# Parâmetros Gerais
$LibInicializacao = "$DirModulos\Jabot-Inicializacao.psm1"
Import-Module -Name $LibInicializacao -DisableNameChecking

# Funções Gerais
$LibFuncoes = "$DirModulos\Jabot-Funcoes.psm1"
Import-Module -Name $LibFuncoes -DisableNameChecking

# Notificações
$LibConfig = "$DirModulos\Jabot-Config.psm1"
Import-Module -Name $LibConfig -DisableNameChecking

# Notificações
$LibNotificacoes = "$DirModulos\Jabot-Notificacoes.psm1"
Import-Module -Name $LibNotificacoes -DisableNameChecking

Add-Type -AssemblyName 'System.Windows.Forms'
Add-Type -AssemblyName 'System.Drawing'

[Void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms.VisualStyles')

# Instancia a aplicação
$FormJabot = New-Object System.Windows.Forms.Form
$ObjetoJabot = New-Object System.Windows.Forms.NotifyIcon

# Inicializa os recursos da aplicação
Inicia-Configs
Cria-Menu
Cria-Estilo

if (!$(Test-Administrator)){
    Toast-Titulo-Imagem -Titulo "Não estou rodando como Administrador! Não garanto se vou funcionar..." -Imagem $AppSettings.PeixeOFF          
}

# Exibe a aplicação
[System.Windows.Forms.Application]::Run($FormJabot)

# Só chega nesse ponto ao fechar a aplicação
Encerra-Jabot