-- AlterTable
ALTER TABLE "Unidades" ADD COLUMN "ganancia" INTEGER DEFAULT 0;

-- CreateTable
CREATE TABLE "Venta" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "products_id" TEXT NOT NULL,
    "factura" INTEGER NOT NULL,
    "ganancia" INTEGER NOT NULL
);
