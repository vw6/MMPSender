$configFile = "SendMail_config.json"
$json = Get-Content $configFile | ConvertFrom-Json 
#Приветствие
Write-Host "Server: " -NoNewline -ForegroundColor Blue
Write-Host ($json.settings.serverSmtp + ":"+$json.settings.Port) -ForegroundColor Green
Write-Host "User sender: " -NoNewline -ForegroundColor Blue
Write-Host ($json.settings.MyName + " ("+$json.settings.Login+")") -ForegroundColor Green
Write-Host "Search path: " -NoNewline -ForegroundColor Blue
Write-Host ($json.settings.FilePath) -ForegroundColor Green
Write-Host ("")
$launchPermission = Read-Host("Start mailing? Yes/No")
Write-Host ("")
if ($launchPermission -eq "Yes" -or $launchPermission -eq "Y") {
   #Создаем экземпляр класса подключения к SMTP серверу
   $smtp = New-Object Net.Mail.SmtpClient($json.settings.serverSmtp, $json.settings.port)
   #Сервер использует SSL
   $smtp.EnableSSL = $True
   #Создаем экземпляр класса для авторизации на сервере
   $smtp.Credentials = New-Object System.Net.NetworkCredential($json.settings.Login, $json.settings.Password);
   #Добавляем файлы и определяем пользователя
   foreach ($user in $json.users) { 
      #Формируем данные для отправки
      $mes = New-Object System.Net.Mail.MailMessage
      $mes.From = $json.settings.MyName
      $mes.Subject = $json.settings.MailSubject
      $mes.IsBodyHTML = $True
      $mes.Body = $json.settings.MailBody
      $mes.To.Add($user.MailTo)
      Write-Host($user.name) -ForegroundColor Blue -NoNewline
      Write-Host ": Search attachments ..."
      #Write-Host "Путь для поиска: "  -ForegroundColor Gray -NoNewline
      #Write-Host  $($json.settings.FilePath +'/'+ $user.name)
      Get-ChildItem -Path $($json.settings.FilePath +'/'+ $user.name) -Filter ($json.settings.FileMask) | where-object {
         ($_.LastWriteTime -ge (get-date).AddDays($json.settings.LastTimeAccessFile))}|
      ForEach-Object{
         Write-Host "File to send: " -ForegroundColor Blue -NoNewline
         Write-Host($_.FullName)
         $att = (New-object Net.Mail.Attachment( $_.FullName))
         $mes.Attachments.Add($att) 
         #$att.Dispose()
      }
      #Отправляем письмо, освобождаем память
      $smtp.Send($mes)
      try{
      Write-Host ("Message sent to user: ")-ForegroundColor Blue -NoNewline
      write-host $user.name -ForegroundColor Green
      $att.Dispose()
      $mes.Dispose()
      write-host("========================")
      }
      catch{
         Write-Host('There were no investments') -ForegroundColor Red
         write-host("========================")

      }
   }
}
