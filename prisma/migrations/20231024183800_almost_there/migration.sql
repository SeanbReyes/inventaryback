/*
  Warnings:

  - You are about to drop the column `fecha_de_rebaja` on the `Unidades` table. All the data in the column will be lost.
  - Added the required column `costo` to the `Factura_Compra` table without a default value. This is not possible if the table is not empty.
  - Added the required column `precio` to the `Factura_Venta` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Factura_Compra" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "proveedor" TEXT NOT NULL,
    "num_factura" INTEGER NOT NULL,
    "products_id" TEXT NOT NULL,
    "costo" INTEGER NOT NULL,
    "fecha" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Factura_Compra" ("id", "num_factura", "products_id", "proveedor") SELECT "id", "num_factura", "products_id", "proveedor" FROM "Factura_Compra";
DROP TABLE "Factura_Compra";
ALTER TABLE "new_Factura_Compra" RENAME TO "Factura_Compra";
CREATE TABLE "new_Unidades" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_articulo" INTEGER NOT NULL,
    "precio_de_compra" INTEGER NOT NULL,
    "precio_de_venta" INTEGER,
    "numero_de_factura" INTEGER NOT NULL,
    "fecha_de_creacion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_de_modificacion" DATETIME,
    "fecha_de_venta" DATETIME,
    "vendido" BOOLEAN DEFAULT false,
    "cliente_compra" TEXT NOT NULL,
    "cliente_venta" TEXT,
    "ganancia" INTEGER DEFAULT 0
);
INSERT INTO "new_Unidades" ("cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_modificacion", "ganancia", "id", "id_articulo", "numero_de_factura", "precio_de_compra", "precio_de_venta", "vendido") SELECT "cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_modificacion", "ganancia", "id", "id_articulo", "numero_de_factura", "precio_de_compra", "precio_de_venta", "vendido" FROM "Unidades";
DROP TABLE "Unidades";
ALTER TABLE "new_Unidades" RENAME TO "Unidades";
CREATE TABLE "new_Factura_Venta" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "products_id" TEXT NOT NULL,
    "num_factura" INTEGER NOT NULL,
    "ganancia" INTEGER NOT NULL,
    "precio" INTEGER NOT NULL,
    "cliente" TEXT NOT NULL,
    "fecha" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Factura_Venta" ("cliente", "ganancia", "id", "num_factura", "products_id") SELECT "cliente", "ganancia", "id", "num_factura", "products_id" FROM "Factura_Venta";
DROP TABLE "Factura_Venta";
ALTER TABLE "new_Factura_Venta" RENAME TO "Factura_Venta";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
