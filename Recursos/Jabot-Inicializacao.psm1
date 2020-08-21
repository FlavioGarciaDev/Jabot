function Cria-Menu {
    param()
    process{

        #----------------------------- MENU -----------------------------#

        # Separadores
        $MenuSeparador = New-Object System.Windows.Forms.ToolStripSeparator

        # Containers
        $MenuContexto = New-Object System.Windows.Forms.ContextMenuStrip # Container principal

        # Itens
        $MenuSair = New-Object System.Windows.Forms.ToolStripMenuItem # Sair
        $MenuCredencial = New-Object System.Windows.Forms.ToolStripMenuItem # Credenciais
        $MenuConfig = New-Object System.Windows.Forms.ToolStripMenuItem # Config
        $MenuParaInicia = New-Object System.Windows.Forms.ToolStripMenuItem # Parar/Iniciar App
        $MenuPlanilhaPonto = New-Object System.Windows.Forms.ToolStripMenuItem # Planilha de Ponto

        #------------------------ COMPORTAMENTOS ------------------------#

        # Menu Iniciar/Parar Processamento
        $MenuParaInicia.Image = [System.Drawing.Bitmap]::FromFile($AppSettings.ImgMenuPlay)
        $MenuParaInicia.Text = "Ativar Notificações"
        $MenuParaInicia.Add_Click({Inicia-Para-Notificacoes -MenuParaInicia $this})

        # Menu Credencial
        $MenuCredencial.Image = [System.Drawing.Bitmap]::FromFile($AppSettings.ImgMenuCredencial)
        $MenuCredencial.Text = "Alterar Credenciais BS2 (Desativado)"
        $MenuCredencial.Add_Click({Atualiza-Credenciais-BS2})
        $MenuCredencial.Enabled = $false

        # Menu Planilha de Ponto
        $MenuPlanilhaPonto.Image = [System.Drawing.Bitmap]::FromFile($AppSettings.ImgMenuPlanilha)
        $MenuPlanilhaPonto.Text = "Planilha de Ponto"
        $MenuPlanilhaPonto.Add_Click({Start-Process $($AppSettings.JabotINI.Dados.URLPlanilhaPonto)})

        # Menu Config
        $MenuConfig.Image = [System.Drawing.Bitmap]::FromFile($AppSettings.ImgMenuConfig)
        $MenuConfig.Text = "Configurar Horários"
        $MenuConfig.Add_Click({
                Abrir-Config-Jabot -AppSettings $AppSettings
                $AppSettings.JabotINI = Get-IniContent -FilePath $AppSettings.JabotINIDir
            })

        #- SAIR -#
        $MenuSair.Image = [System.Drawing.Bitmap]::FromFile($AppSettings.ImgMenuSair)
        $MenuSair.Text = "Sair"
        $MenuSair.Add_Click({$FormJabot.Close()})

        # Array final
        $MenuArray = $MenuParaInicia, $MenuCredencial, $MenuPlanilhaPonto, $MenuSeparador, $MenuConfig, $MenuSair

        # Associando o array final ao menu de contexto
        $MenuContexto.Items.AddRange($MenuArray)
        $MenuContexto.DropShadowEnabled = $TRUE

        # Associando o objeto menu aos controloradores
        $ObjetoJabot.ContextMenuStrip = $MenuContexto
    }
}

function Cria-Estilo {
    param()
    process{
        #--- Parâmetros da Form, menu de contexto e notificação ---#

        # Objeto que ficará como as notificações
        $ObjetoJabot.Text = $AppSettings.NotificacoesInativo
        $ObjetoJabot.Icon = $AppSettings.IcoPeixeOFF

        # Preparando a Form (necessária para criar o menu contexto)
        $FormJabot.Text = $AppSettings.NomeAplicacao
        $FormJabot.Name = 'FormJabot'
        $FormJabot.DataBindings.DefaultDataSourceUpdateMode = 0
        $FormJabot.ClientSize =  '200,156'
        $FormJabot.TopMost = $TRUE
        $FormJabot.ShowInTaskbar = $FALSE
        $FormJabot.Opacity = 0
        $FormJabot.Icon = $AppSettings.IcoPeixeOFF
        $FormJabot.ShowIcon = $TRUE
        $FormJabot.FormBorderStyle = "FixedToolWindow"

        $ObjetoJabot.Visible = $TRUE
    }
}

function Inicia-Configs {
    param()
    process{

        # -CONFIGS BÁSICAS- #
        $DirPrincipal = (Get-Item $PSScriptRoot).Parent.FullName
        $JabotINI = "Jabot.ini"

        $DirImagensPerfil = "$DirPrincipal\Imagens\Perfil"
        $DirImagensBanner = "$DirPrincipal\Imagens\Banner"
        $DirImagensIcones = "$DirPrincipal\Imagens\Icones"
        $DirImagensIconesMenu = "$DirPrincipal\Imagens\Icones\Menu"
        $DirImagensIconesBotoes = "$DirPrincipal\Imagens\Icones\Botoes"

        $DirSons = "$DirPrincipal\Sons"

        $AppSettings.Add('JabotINIDir', "$DirPrincipal\$JabotINI")
        $AppSettings.Add('JabotINI', (Get-IniContent $AppSettings.JabotINIDir))
        $AppSettings.Add('NomeAplicacao', "JABOT®")
        $AppSettings.Add('DirPrincipal', $DirPrincipal)
        $AppSettings.Add('DirRecursos', $PSScriptRoot)

        $AppSettings.Add('ArquivoFrasesTFS', "$DirPrincipal\Frases\FrasesTFS.txt")
        $AppSettings.Add('ArquivoFrasesNetsuite', "$DirPrincipal\Frases\FrasesNetsuite.txt")
        $AppSettings.Add('ArquivoFrasesCerveja', "$DirPrincipal\Frases\FrasesCerveja.txt")
        $AppSettings.Add('ArquivoFrasesFolhaPonto', "$DirPrincipal\Frases\FrasesFolhaPonto.txt")

        $AppSettings.Add('DirSons', $DirSons)
        $AppSettings.Add('ArquivoAlertas', "$DirSons\Alertas.txt")

        $AppSettings.Add('DirImagensPerfil', "$DirImagensPerfil")
        $AppSettings.Add('DirImagensBanner', "$DirImagensBanner")
        $AppSettings.Add('DirImagensIcones', "$DirImagensIcones")
        $AppSettings.Add('DirImagensIconesMenu', $DirImagensIconesMenu)
        $AppSettings.Add('DirImagensIconesBotoes', $DirImagensIconesBotoes)

        # -ÍCONES E IMAGENS- #
        # Icone aplicação
        $AppSettings.Add('IcoPeixeON', "$DirImagensIcones\PeixeON.ico")
        $AppSettings.Add('IcoPeixeOFF', "$DirImagensIcones\PeixeOFF.ico")
        $AppSettings.Add('IcoConfig', "$DirImagensIcones\Config.ico")

        # Ícones do Menu
        $AppSettings.Add('ImgMenuSair', "$DirImagensIconesMenu\door_out.png")
        $AppSettings.Add('ImgMenuStop', "$DirImagensIconesMenu\stop_red.png")
        $AppSettings.Add('ImgMenuPlay', "$DirImagensIconesMenu\play_green.png")
        $AppSettings.Add('ImgMenuCredencial', "$DirImagensIconesMenu\key.png")
        $AppSettings.Add('ImgMenuConfig', "$DirImagensIconesMenu\wrench.png")
        $AppSettings.Add('ImgMenuPlanilha', "$DirImagensIconesMenu\page_white_excel.png")

        # Ícones dos Botões
        $AppSettings.Add('ImgBotaoConfirma', "$DirImagensIconesBotoes\tick.png")
        $AppSettings.Add('ImgBotaoSoneca', "$DirImagensIconesBotoes\clock_red.png")

        # Imagens de Notificações
        $AppSettings.Add('PeixeON', "$DirImagensIcones\PeixeON.png")
        $AppSettings.Add('PeixeOFF', "$DirImagensIcones\PeixeOFF.png")

        # Mensagens
        $AppSettings.Add("NotificacoesAtivo","$($AppSettings.NomeAplicacao) - Tô na sua cola!")
        $AppSettings.Add("NotificacoesInativo","$($AppSettings.NomeAplicacao) - Não vou te incomodar...")

    }

}

