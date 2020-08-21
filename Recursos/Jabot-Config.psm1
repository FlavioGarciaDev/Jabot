function Abrir-Config-Jabot {
    param($AppSettings)
    process{

        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Application]::EnableVisualStyles()

        $Form                            = New-Object system.Windows.Forms.Form
        $Form.ClientSize                 = '400,547'
        $Form.text                       = "Configurações"
        $Form.TopMost                    = $False
	    $Form.Icon = New-Object System.Drawing.Icon ($AppSettings.IcoConfig)
	    $Form.MaximizeBox = $False
        $Form.ShowInTaskbar = $False
        $Form.FormBorderStyle = "FixedDialog"
        $Form.ShowIcon = $True

        $Label5                          = New-Object system.Windows.Forms.Label
        $Label5.text                     = "[TFS]"
        $Label5.AutoSize                 = $true
        $Label5.width                    = 25
        $Label5.height                   = 10
        $Label5.location                 = New-Object System.Drawing.Point(15,17)
        $Label5.Font                     = 'Microsoft Sans Serif,10,style=Bold'

        $Label52                          = New-Object system.Windows.Forms.Label
        $Label52.text                     = "Todos os dias"
        $Label52.AutoSize                 = $true
        $Label52.width                    = 25
        $Label52.height                   = 10
        $Label52.location                 = New-Object System.Drawing.Point(60,20)
        $Label52.Font                     = 'Microsoft Sans Serif,8,style=Italic'

        $Label6                          = New-Object system.Windows.Forms.Label
        $Label6.text                     = "Horário:"
        $Label6.AutoSize                 = $true
        $Label6.width                    = 25
        $Label6.height                   = 10
        $Label6.location                 = New-Object System.Drawing.Point(15,45)
        $Label6.Font                     = 'Microsoft Sans Serif,10'

        $Label8                          = New-Object system.Windows.Forms.Label
        $Label8.text                     = "URL:"
        $Label8.AutoSize                 = $true
        $Label8.width                    = 25
        $Label8.height                   = 10
        $Label8.location                 = New-Object System.Drawing.Point(15,71)
        $Label8.Font                     = 'Microsoft Sans Serif,10'

        $MaskedTextBox4                        = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox4.multiline              = $false
        $MaskedTextBox4.width                  = 57
        $MaskedTextBox4.height                 = 20
        $MaskedTextBox4.location               = New-Object System.Drawing.Point(80,37)
        $MaskedTextBox4.Font                   = 'Microsoft Sans Serif,10'
        $MaskedTextBox4.mask                   = "00:00"
        $MaskedTextBox4.TabIndex = 1
        $MaskedTextBox4.Text = $AppSettings.JabotINI.TFS.Horario

        $MaskedTextBox6                        = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox6.multiline              = $false
        $MaskedTextBox6.width                  = 284
        $MaskedTextBox6.height                 = 20
        $MaskedTextBox6.location               = New-Object System.Drawing.Point(80,63)
        $MaskedTextBox6.Font                   = 'Microsoft Sans Serif,10'
        $MaskedTextBox6.TabIndex = 3
        $MaskedTextBox6.Text = $AppSettings.JabotINI.TFS.URL

        $Label9                          = New-Object system.Windows.Forms.Label
        $Label9.text                     = "[Netsuite]"
        $Label9.AutoSize                 = $true
        $Label9.width                    = 25
        $Label9.height                   = 10
        $Label9.location                 = New-Object System.Drawing.Point(15,111)
        $Label9.Font                     = 'Microsoft Sans Serif,10,style=Bold'

        $Label92                          = New-Object system.Windows.Forms.Label
        $Label92.text                     = "Toda segunda-feira"
        $Label92.AutoSize                 = $true
        $Label92.width                    = 25
        $Label92.height                   = 10
        $Label92.location                 = New-Object System.Drawing.Point(85,114)
        $Label92.Font                     = 'Microsoft Sans Serif,8,style=Italic'

        $Label10                         = New-Object system.Windows.Forms.Label
        $Label10.text                    = "Horário:"
        $Label10.AutoSize                = $true
        $Label10.width                   = 25
        $Label10.height                  = 10
        $Label10.location                = New-Object System.Drawing.Point(15,140)
        $Label10.Font                    = 'Microsoft Sans Serif,10'

        $Label12                         = New-Object system.Windows.Forms.Label
        $Label12.text                    = "URL:"
        $Label12.AutoSize                = $true
        $Label12.width                   = 25
        $Label12.height                  = 10
        $Label12.location                = New-Object System.Drawing.Point(15,165)
        $Label12.Font                    = 'Microsoft Sans Serif,10'

        
        $MaskedTextBox7                        = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox7.multiline              = $false
        $MaskedTextBox7.width                  = 57
        $MaskedTextBox7.height                 = 20
        $MaskedTextBox7.location               = New-Object System.Drawing.Point(80,133)
        $MaskedTextBox7.Font                   = 'Microsoft Sans Serif,10'
        $MaskedTextBox7.mask                   = "00:00"
        $MaskedTextBox7.TabIndex = 4
        $MaskedTextBox7.Text = $AppSettings.JabotINI.Netsuite.Horario

        $MaskedTextBox9                        = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox9.multiline              = $false
        $MaskedTextBox9.width                  = 284
        $MaskedTextBox9.height                 = 20
        $MaskedTextBox9.location               = New-Object System.Drawing.Point(80,159)
        $MaskedTextBox9.Font                   = 'Microsoft Sans Serif,10'
        $MaskedTextBox9.TabIndex = 6
        $MaskedTextBox9.Text = $AppSettings.JabotINI.Netsuite.URL

        $Label13                         = New-Object system.Windows.Forms.Label
        $Label13.text                    = "[Folha de Ponto]"
        $Label13.AutoSize                = $true
        $Label13.width                   = 25
        $Label13.height                  = 10
        $Label13.location                = New-Object System.Drawing.Point(15,205)
        $Label13.Font                    = 'Microsoft Sans Serif,10,style=Bold'

        $Label132                          = New-Object system.Windows.Forms.Label
        $Label132.text                     = "Todo último dia útil do mês"
        $Label132.AutoSize                 = $true
        $Label132.width                    = 25
        $Label132.height                   = 10
        $Label132.location                 = New-Object System.Drawing.Point(130,208)
        $Label132.Font                     = 'Microsoft Sans Serif,8,style=Italic'

        $Label14                         = New-Object system.Windows.Forms.Label
        $Label14.text                    = "Horário:"
        $Label14.AutoSize                = $true
        $Label14.width                   = 25
        $Label14.height                  = 10
        $Label14.location                = New-Object System.Drawing.Point(15,233)
        $Label14.Font                    = 'Microsoft Sans Serif,10'

        $Label16                         = New-Object system.Windows.Forms.Label
        $Label16.text                    = "URL:"
        $Label16.AutoSize                = $true
        $Label16.width                   = 25
        $Label16.height                  = 10
        $Label16.location                = New-Object System.Drawing.Point(15,259)
        $Label16.Font                    = 'Microsoft Sans Serif,10'

        $MaskedTextBox10                       = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox10.multiline             = $false
        $MaskedTextBox10.width                 = 57
        $MaskedTextBox10.height                = 20
        $MaskedTextBox10.location              = New-Object System.Drawing.Point(80,225)
        $MaskedTextBox10.Font                  = 'Microsoft Sans Serif,10'
        $MaskedTextBox10.mask                   = "00:00"
        $MaskedTextBox10.TabIndex = 7
        $MaskedTextBox10.Text = $AppSettings.JabotINI.FolhaPonto.Horario

        $MaskedTextBox12                       = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox12.multiline             = $false
        $MaskedTextBox12.width                 = 284
        $MaskedTextBox12.height                = 20
        $MaskedTextBox12.location              = New-Object System.Drawing.Point(80,251)
        $MaskedTextBox12.Font                  = 'Microsoft Sans Serif,10'
        $MaskedTextBox12.TabIndex = 9
        $MaskedTextBox12.Text = $AppSettings.JabotINI.FolhaPonto.URL

        $Label17                         = New-Object system.Windows.Forms.Label
        $Label17.text                    = "[Cerveja]"
        $Label17.AutoSize                = $true
        $Label17.width                   = 25
        $Label17.height                  = 10
        $Label17.location                = New-Object System.Drawing.Point(15,294)
        $Label17.Font                    = 'Microsoft Sans Serif,10,style=Bold'

        $Label172                          = New-Object system.Windows.Forms.Label
        $Label172.text                     = "Toda sexta-feira"
        $Label172.AutoSize                 = $true
        $Label172.width                    = 25
        $Label172.height                   = 10
        $Label172.location                 = New-Object System.Drawing.Point(85,297)
        $Label172.Font                     = 'Microsoft Sans Serif,8,style=Italic'

        $Label18                         = New-Object system.Windows.Forms.Label
        $Label18.text                    = "Horário:"
        $Label18.AutoSize                = $true
        $Label18.width                   = 25
        $Label18.height                  = 10
        $Label18.location                = New-Object System.Drawing.Point(15,322)
        $Label18.Font                    = 'Microsoft Sans Serif,10'

        $Label20                         = New-Object system.Windows.Forms.Label
        $Label20.text                    = "URL:"
        $Label20.AutoSize                = $true
        $Label20.width                   = 25
        $Label20.height                  = 10
        $Label20.location                = New-Object System.Drawing.Point(15,348)
        $Label20.Font                    = 'Microsoft Sans Serif,10'

        $MaskedTextBox13                       = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox13.multiline             = $false
        $MaskedTextBox13.width                 = 57
        $MaskedTextBox13.height                = 20
        $MaskedTextBox13.location              = New-Object System.Drawing.Point(80,316)
        $MaskedTextBox13.Font                  = 'Microsoft Sans Serif,10'
        $MaskedTextBox13.mask                   = "00:00"
        $MaskedTextBox13.TabIndex = 10
        $MaskedTextBox13.Text = $AppSettings.JabotINI.Cerveja.Horario

        $MaskedTextBox15                       = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox15.multiline             = $false
        $MaskedTextBox15.width                 = 284
        $MaskedTextBox15.height                = 20
        $MaskedTextBox15.location              = New-Object System.Drawing.Point(80,342)
        $MaskedTextBox15.Font                  = 'Microsoft Sans Serif,10'
        $MaskedTextBox15.TabIndex = 12
        $MaskedTextBox15.Text = $AppSettings.JabotINI.Cerveja.URL

        $Label1                          = New-Object system.Windows.Forms.Label
        $Label1.text                     = "[Almoço] (não implementado ainda)"
        $Label1.AutoSize                 = $true
        $Label1.width                    = 25
        $Label1.height                   = 10
        $Label1.location                 = New-Object System.Drawing.Point(15,389)
        $Label1.Font                     = 'Microsoft Sans Serif,10,style=Bold'

        $Label122                          = New-Object system.Windows.Forms.Label
        $Label122.text                     = "Todos os dias"
        $Label122.AutoSize                 = $true
        $Label122.width                    = 25
        $Label122.height                   = 10
        $Label122.location                 = New-Object System.Drawing.Point(250,392)
        $Label122.Font                     = 'Microsoft Sans Serif,8,style=Italic'

        $Label2                          = New-Object system.Windows.Forms.Label
        $Label2.text                     = "Horário:"
        $Label2.AutoSize                 = $true
        $Label2.width                    = 25
        $Label2.height                   = 10
        $Label2.location                 = New-Object System.Drawing.Point(15,417)
        $Label2.Font                     = 'Microsoft Sans Serif,10'

        $Label4                          = New-Object system.Windows.Forms.Label
        $Label4.text                     = "URL:"
        $Label4.AutoSize                 = $true
        $Label4.width                    = 25
        $Label4.height                   = 10
        $Label4.location                 = New-Object System.Drawing.Point(15,443)
        $Label4.Font                     = 'Microsoft Sans Serif,10'

        $MaskedTextBox1                        = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox1.multiline              = $false
        $MaskedTextBox1.width                  = 57
        $MaskedTextBox1.height                 = 20
        $MaskedTextBox1.location               = New-Object System.Drawing.Point(80,411)
        $MaskedTextBox1.Font                   = 'Microsoft Sans Serif,10'
        $MaskedTextBox1.mask                   = "00:00"
        $MaskedTextBox1.TabIndex = 13
        $MaskedTextBox1.Text = $AppSettings.JabotINI.Almoco.Horario

        $MaskedTextBox3                        = New-Object system.Windows.Forms.MaskedTextBox
        $MaskedTextBox3.multiline              = $false
        $MaskedTextBox3.width                  = 284
        $MaskedTextBox3.height                 = 20
        $MaskedTextBox3.location               = New-Object System.Drawing.Point(80,437)
        $MaskedTextBox3.Font                   = 'Microsoft Sans Serif,10'
        $MaskedTextBox3.TabIndex = 15
        $MaskedTextBox3.Text = $AppSettings.JabotINI.Almoco.URL

        $Button1                         = New-Object system.Windows.Forms.Button
        $Button1.text                    = "Cancelar"
        $Button1.width                   = 85
        $Button1.height                  = 30
        $Button1.location                = New-Object System.Drawing.Point(295,501)
        $Button1.Font                    = 'Microsoft Sans Serif,10,style=Bold'

        $Button2                         = New-Object system.Windows.Forms.Button
        $Button2.text                    = "Confirmar"
        $Button2.width                   = 85
        $Button2.height                  = 30
        $Button2.location                = New-Object System.Drawing.Point(196,501)
        $Button2.Font                    = 'Microsoft Sans Serif,10,style=Bold'

        $Form.controls.AddRange(@($Label1,$Label122,$Label2,$Label132,$Label172,$Label92,$Label4,$MaskedTextBox1,$MaskedTextBox3,$Label5,$Label52,$Label6,$Label8,$Label9,$Label10,$Label12,$MaskedTextBox7,$MaskedTextBox9,$Label13,$Label14,$Label16,$MaskedTextBox10,$MaskedTextBox12,$Label17,$Label18,$Label20,$MaskedTextBox13,$MaskedTextBox15,$MaskedTextBox4,$MaskedTextBox6,$Button1, $Button2))

        $Button2.Add_Click({
            $AppSettings.JabotINI.TFS.Horario = $MaskedTextBox4.Text
            $AppSettings.JabotINI.TFS.URL = $MaskedTextBox6.Text
            $AppSettings.JabotINI.Netsuite.Horario = $MaskedTextBox7.Text
            $AppSettings.JabotINI.Netsuite.URL = $MaskedTextBox9.Text
            $AppSettings.JabotINI.FolhaPonto.Horario = $MaskedTextBox10.Text
            $AppSettings.JabotINI.FolhaPonto.URL = $MaskedTextBox12.Text
            $AppSettings.JabotINI.Cerveja.Horario = $MaskedTextBox13.Text
            $AppSettings.JabotINI.Cerveja.URL = $MaskedTextBox15.Text
            $AppSettings.JabotINI.Almoco.Horario = $MaskedTextBox1.Text
            $AppSettings.JabotINI.Almoco.URL = $MaskedTextBox3.Text

           Out-IniFile -InputObject $AppSettings.JabotINI -FilePath $AppSettings.JabotINIDir -Passthru -Force
           $Form.Close()

           Toast-Titulo-Imagem -Titulo "Deixa comigo meu peixe! Fica tranquilo porque não sou burro, só sou lento." -Imagem $AppSettings.PeixeON
        })

        $Form.AcceptButton = $Button2
        $Form.CancelButton = $Button1
  
        $Form.ShowDialog()

    }

}