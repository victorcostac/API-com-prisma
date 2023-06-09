-- CreateTable
CREATE TABLE "empresas" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome_fantasia" TEXT NOT NULL,
    "razao_social" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true
);

-- CreateTable
CREATE TABLE "usuarios" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "nome_usuario" TEXT NOT NULL,
    "mac_auth" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT "usuarios_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "clientes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "codigo_cliente" TEXT,
    "razao_social" TEXT,
    "nome_fantasia" TEXT NOT NULL,
    "cnpj" INTEGER,
    "IE" INTEGER,
    "segmento" TEXT,
    "email_empresarial" TEXT,
    "endereco" TEXT,
    "bairro" TEXT,
    "cidade" TEXT,
    "cep" TEXT,
    "uf" TEXT,
    "numero" TEXT,
    "telefone" TEXT,
    "whatsapp" TEXT,
    "contator" TEXT,
    "resp_empresa" TEXT,
    "email" TEXT,
    "observacao" TEXT,
    "bloqueado" BOOLEAN NOT NULL DEFAULT false,
    "ultima_alteracao" DATETIME NOT NULL,
    CONSTRAINT "clientes_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "clientes_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "formaspgto" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "codigo_formaspgto" INTEGER NOT NULL,
    "descricao" TEXT NOT NULL,
    CONSTRAINT "formaspgto_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "parcelas" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "codigo_parcelas" INTEGER NOT NULL,
    "descricao" TEXT NOT NULL,
    CONSTRAINT "parcelas_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "status_pedido" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "descricao" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "tipo_pedido" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "descricao" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "pedidos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "id_cliente" INTEGER NOT NULL,
    "id_formapgto" INTEGER NOT NULL,
    "id_parcela" INTEGER NOT NULL,
    "id_tabela_pv" INTEGER NOT NULL,
    "datahora" DATETIME NOT NULL,
    "id_tipo_pedido" INTEGER NOT NULL,
    "id_status" INTEGER NOT NULL,
    "total_pedido" DECIMAL NOT NULL,
    "total_desconto" DECIMAL NOT NULL,
    "ultima_alteracao" DATETIME NOT NULL,
    CONSTRAINT "pedidos_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "clientes" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_id_formapgto_fkey" FOREIGN KEY ("id_formapgto") REFERENCES "formaspgto" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_id_parcela_fkey" FOREIGN KEY ("id_parcela") REFERENCES "parcelas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_id_status_fkey" FOREIGN KEY ("id_status") REFERENCES "status_pedido" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_id_tipo_pedido_fkey" FOREIGN KEY ("id_tipo_pedido") REFERENCES "tipo_pedido" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_id_tabela_pv_fkey" FOREIGN KEY ("id_tabela_pv") REFERENCES "tabelas_pv" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "tabelas_pv" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "id_produto" INTEGER NOT NULL,
    "tipo_tab" TEXT NOT NULL,
    "valor_nominal" DECIMAL NOT NULL,
    "desc_valor" DECIMAL NOT NULL,
    "ultima_alteracao" DATETIME NOT NULL,
    CONSTRAINT "tabelas_pv_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "imagens" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "id_produto" INTEGER NOT NULL,
    "imagem" BLOB NOT NULL,
    "ultima_alteracao" DATETIME NOT NULL,
    CONSTRAINT "imagens_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "imagens_id_produto_fkey" FOREIGN KEY ("id_produto") REFERENCES "produtos" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "produtos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_empresa" INTEGER NOT NULL,
    "codigo_produto" INTEGER NOT NULL,
    "descricao" TEXT NOT NULL,
    "referencia" TEXT NOT NULL,
    "marca" TEXT NOT NULL,
    "estoque" DECIMAL NOT NULL,
    "ultima_alteracao" DATETIME NOT NULL,
    CONSTRAINT "produtos_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "empresas" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "pedidos_produtos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_pedido" INTEGER NOT NULL,
    "id_produto" INTEGER NOT NULL,
    "qtde" DECIMAL NOT NULL,
    "valor_nominal" DECIMAL NOT NULL,
    "desc_valor" DECIMAL NOT NULL,
    "total_liquido" DECIMAL NOT NULL,
    "ultima_alteracao" DATETIME NOT NULL,
    CONSTRAINT "pedidos_produtos_id_pedido_fkey" FOREIGN KEY ("id_pedido") REFERENCES "pedidos" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pedidos_produtos_id_produto_fkey" FOREIGN KEY ("id_produto") REFERENCES "produtos" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "empresas_cnpj_key" ON "empresas"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "clientes_cnpj_key" ON "clientes"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "clientes_email_key" ON "clientes"("email");
