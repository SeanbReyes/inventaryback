/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `Articulo` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Articulo_name_key" ON "Articulo"("name");
