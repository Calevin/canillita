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
    private BaseDeDatos db;
	private string nombre_tabla_revistas;
	private string columnas_tabla_revistas;

	public RevistaDAO (BaseDeDatos base_de_datos, string nombre_tabla
	                   , string columnas_tabla) {
		this.db = base_de_datos;
		this.nombre_tabla_revistas = nombre_tabla;
		this.columnas_tabla_revistas = columnas_tabla;
	}
	 
	public Array<Revista> get_revistas () {
		string condicion_vacia = "";
		
		Array<Revista> revistas = new Array<Revista> ();
		Array<GLib.Object> retorno_consulta = new Array<GLib.Object> ();
		
		retorno_consulta = db.select( nombre_tabla_revistas,
		                             columnas_tabla_revistas, condicion_vacia );

		Revista row_revista;
		for (int i = 0; i < retorno_consulta.length; i++) {
			row_revista = retorno_consulta.index (i) as Revista;
			revistas.append_val(row_revista);
		}
		
		return revistas;
	}
}
