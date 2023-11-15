/*
  Warnings:

  - You are about to drop the column `ganancia` on the `Unidades` table. All the data in the column will be lost.
  - You are about to drop the column `precio_de_venta` on the `Unidades` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Unidades" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_articulo" INTEGER NOT NULL,
    "precio_de_compra" INTEGER NOT NULL,
    "numero_de_factura" INTEGER NOT NULL,
    "numero_de_factura_venta" INTEGER,
    "fecha_de_creacion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_de_modificacion" DATETIME,
    "fecha_de_venta" DATETIME,
    "vendido" BOOLEAN DEFAULT false,
    "cliente_compra" TEXT NOT NULL,
    "cliente_venta" TEXT
);
INSERT INTO "new_Unidades" ("cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_modificacion", "fecha_de_venta", "id", "id_articulo", "numero_de_factura", "numero_de_factura_venta", "precio_de_compra", "vendido") SELECT "cliente_compra", "cliente_venta", "fecha_de_creacion", "fecha_de_modificacion", "fecha_de_venta", "id", "id_articulo", "numero_de_factura", "numero_de_factura_venta", "precio_de_compra", "vendido" FROM "Unidades";
DROP TABLE "Unidades";
ALTER TABLE "new_Unidades" RENAME TO "Unidades";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
