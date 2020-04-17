# ExecutarScriptsCaproni

O intuito da aplicação é copiar os scripts para pastas separadas para cada banco e executar o caproni em cada banco, para não termos que ficar copiando os scripts manual para dentro da pasta do caproni e executando um por um em cada banco e modificando as configurações no arquivo config.ini do caproni, sendo necessário configurar somente uma única vez. 

Para copiar os scripts do caproni é necessário que o caproni esteja em uma pasta: 
```bash
C:\CAPRONI_CMD
```
Tem que ter uma BIN para cada banco 
```bash
C:\CAPRONI_CMD\BIN_DB2
C:\CAPRONI_CMD\BIN_ORACLE
C:\CAPRONI_CMD\BIN_SQLSERVER
C:\CAPRONI_CMD\BIN_POSTGRESQL
```

E dentro de cada bin é necessário ter a estrutura normal do caproni, e dentro dos config.ini ter a configuração apontando para o banco de dados referente ao nome da bin

### Funcionalidades

 * Copiar os scripts do SG informados no Memo do caminho de origem de cada banco, para dentro de cada BIN do caproni de cada banco (Ainda vou estudar os scripts POS se terá que ter algum tratamento especial).
 * Executar o caproni dentro das 4 pastas de cada banco. 
 * Quando fecha a tela ele salva o caminho informado no campo "Origem dos scripts"

### Como utilizar
 * Informe o caminho da stream dos scripts do SG Ex.: "C:\RTC\DESKTOP-SG5-DEV\sg5Dev\dbscript\SG".
 * Dentro do memo coloque somente o nome de um script por linha Ex.: "SG111111.DH4". 
 * Clique em "Copiar Scripts" aí os scripts serão copiados para as suas respectivas pastas para cada banco.
 * Clique em "Executar Scripts" será executados no caproni os scripts que foram copiados, abrindo uma tela do DOS para cada banco. 
