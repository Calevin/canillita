/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * revista.vala
 * Copyright (C) 2015 Sebastian Barreto <sebastian.e.barreto@gmail.com>
 *
 * canillita is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * canillita is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class Canillita.Revista : GLib.Object {
  public uint id;
  public uint stock;
  public uint64 codigo_de_barras;
  public string nombre;
  public float precio_de_compra;
  public float precio_de_venta;
  public uint numero;
  public uint anio;

  public Revista () {
  }
}
