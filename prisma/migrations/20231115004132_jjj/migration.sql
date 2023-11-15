-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Factura_Venta" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "products_id" TEXT NOT NULL,
    "num_factura" INTEGER NOT NULL,
    "ganancia" INTEGER NOT NULL,
    "precio" INTEGER NOT NULL,
    "cliente" TEXT NOT NULL,
    "fecha" TEXT NOT NULL
);
INSERT INTO "new_Factura_Venta" ("cliente", "fecha", "ganancia", "id", "num_factura", "precio", "products_id") SELECT "cliente", "fecha", "ganancia", "id", "num_factura", "precio", "products_id" FROM "Factura_Venta";
DROP TABLE "Factura_Venta";
ALTER TABLE "new_Factura_Venta" RENAME TO "Factura_Venta";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
