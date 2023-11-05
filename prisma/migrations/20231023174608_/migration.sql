/*
  Warnings:

  - You are about to drop the `Venta` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Venta";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Factura_Venta" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "products_id" TEXT NOT NULL,
    "num_factura" INTEGER NOT NULL,
    "ganancia" INTEGER NOT NULL,
    "cliente" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Factura_Compra" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "proveedor" TEXT NOT NULL,
    "num_factura" INTEGER NOT NULL,
    "products_id" TEXT NOT NULL
);
