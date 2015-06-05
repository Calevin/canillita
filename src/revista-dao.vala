/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * revista-dao.vala
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

public class Canillita.RevistaDAO {
	private BaseDeDatos db = new BaseDeDatos();
	private string nombre_tabla_revistas = "revistas";
	private string columnas_tabla_revistas = "codigo_de_barras, nombre,
		precio_de_compra, precio_de_venta, numero, anio";
	 
	public Array<Revista> get_revistas () {
		string condicion_vacia = "";
		
		Array<Revista> revistas = new Array<Revista> ();
		Array<GLib.Object> retorno_consulta = new Array<GLib.Object> ();
		
		retorno_consulta = db.select( nombre_tabla_revistas,
		                             columnas_tabla_revistas, condicion_vacia );
		
		for (int i = 0; i < retorno_consulta.length; i++) {
			Revista row_revista = (Revista) retorno_consulta.index (i);
			revistas.append_val(row_revista);
		}
		
		return revistas;
	}

}

