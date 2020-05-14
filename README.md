# ExecutarScriptsCaproni

O intuito da aplicação é copiar os scripts para pastas separadas para cada banco e executar o caproni em cada banco, para não termos que ficar copiando os scripts manual para dentro da pasta do caproni e executando um por um em cada banco e modificando as configurações no arquivo config.ini do caproni, sendo necessário configurar somente uma única vez. 

### Configurações
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

Templates para o arquivo "config.ini"

Existe uma pasta "Templates" na raiz do projeto que deve estar no mesmo diretório do executável. (Ia colocar o executável para gerar todos esses templates, mas achei que ia dar trabalho hehe então subi junto com os fontes, em uma próxima atualização talvez coloque dentro do executável esses arquivos, hehe.)

Esses Templates são dos arquivos de configurações (config.ini) para informar em qual banco de dados irá rodar cada script, o ideal é entrar em cada um e configurar uma única vez. Caso os dados da configuração mude é só ir nessa pasta e fazer a configuração correta. 

E dentro de cada bin é necessário ter a estrutura normal do caproni. O arquivo config.ini deve ser configurado dentro da pasta Templates, pois devido a ter SG e PG é necessário ficar trocando o arquivo de configuração, por isso não é possível deixar essa configuração fixa dentro de cada pasta BIN de cada banco. 

### Funcionalidades

 * Copiar os scripts do SG/PG informados no Memo do caminho de origem de cada banco, para dentro de cada BIN do caproni de cada banco (Ainda vou estudar os scripts POS se terá que ter algum tratamento especial).
 * Executar o caproni dentro das 4 pastas de cada banco. 
 * Quando fecha a tela ele salva o caminho informado no campo "Origem dos scripts"

### Como utilizar
 * Informe o caminho da stream dos scripts do SG Ex.: "C:\RTC\DESKTOP-SG5-DEV\sg5Dev\dbscript\SG".
 * Dentro do memo coloque somente o nome de um script por linha Ex.: "SG111111.DH4". 
 * Clique em "Copiar Scripts" aí os scripts e os config.ini serão copiados para as suas respectivas pastas para cada banco.
 * Clique em "Executar Scripts" será executados no caproni os scripts que foram copiados, abrindo uma tela do DOS para cada banco. 
