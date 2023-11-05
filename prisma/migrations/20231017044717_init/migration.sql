/*
  Warnings:

  - You are about to drop the `Task` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Task";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Articulo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "valor_total" INTEGER NOT NULL,
    "disponibles" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Unidades" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_articulo" INTEGER NOT NULL,
    "precio_de_compra" INTEGER NOT NULL,
    "numero_de_factura" INTEGER NOT NULL,
    "fecha_de_creacion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_de_rebaja" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cliente_compra" TEXT NOT NULL,
    "cliente_venta" TEXT
);
