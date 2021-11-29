# MMPSender

## ENG

This is a small script for mass mailing mail: postcards, invoices, gifts, etc.

Supports sending only fresh files, no older than, for example, N days.

An unlimited number of destinations can be used.

The addressees are pre-registered in the configuration file. If you need to send files to users, check the user's folder along the path you specified in the FileMask block.

Please do not use it for spam submissions.

## RUS

Это небольшой скрипт для массовой рассылки почты: открыток, счетов-фактур, подарков и т. Д.

Поддерживает отправку только свежих файлов, не старше, например, N дней.

Можно использовать неограниченное количество направлений.

Адресаты предварительно прописаны в файле конфигурации. Если вам нужно отправить файлы пользователям, проверьте папку пользователя по пути, который вы указали в блоке FileMask.

Пожалуйста, не используйте его для рассылки спама.

```
{
  "settings": [
    {
      "MyName":"Admin <admin@vw6.ru>",
      "Login":"example_ligin", 
      "Password":"example_Password",
      "FilePath":"/patch/to/file/sendmail",
      "FileMask":"*",
      "LastTimeAccessFile":"-10",
      "MailSubject": "Test",
      "MailBody": "<h1>qwe</h1><p>asd</p>",
      "serverSmtp": "example.server.com",
      "Port": "25"
    }
  ],
  "users": [
    {
      "name": "user1",
      "MailTo": "proshin1@vw6.ru"
    },
    {
      "name": "user2",
      "MailTo": "proshin2@vw6.ru"
    }
  ]
}
```
## Description of the "settings" block

Name                | Description                                                                             | Example                 | 
---                 | ---                                                                                     | ---                     |
MyName              | Your name is indicated in the letter                                                    | Admin <admin@vw6.ru>    |
Login               | The login for authorization on the mail server is specified                             | login                   |
Password            | The password for authorization on the mail server is specified                          | Password123             |
FilePath            | The path to the folder with the folders corresponding to user is indicated              | /home/user/mail/        |
FileMask            | File filter                                                                             | *                       |
LastTimeAccessFile  | The freshness of the files is indicated. The example shows files less than 10 days old  | -10                     |
MailSubject         | Letter subject                                                                          | Hello                   |
MailBody            | Body of the letter                                                                      | `<h1>qwe</h1><p>asd</p>`|
serverSmtp          | Smtp server address                                                                     | example.server.com      |
Port                | Server port                                                                             | 25                      |

## Description of the "users" block

Name                | Description                                                                             | Example                 | 
---                 | ---                                                                                     | ---                     |
Login               | The login for authorization on the mail server is specified                             | User1                   |
MailTo              | Is described a user's letter will be sent to the cookie mail                            | proshin@vw6.ru          |










