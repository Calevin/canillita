/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * canillita-liststore-revistas.vala
 * Copyright (C) 2015 Andres Fernandez <andres@softwareperonista.com.ar>
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

using Canillita;

public class Canillita.ListStoreRevistas : Gtk.ListStore {
	private GLib.Array<Revista> revistas;

	ListStoreRevistas () {
		Type[] tipos = { typeof(uint64),
						typeof(string),
						typeof(uint),
						typeof(uint),
						typeof(float),
						typeof(uint) };
		this.set_column_types ( tipos );

		this.revistas = new GLib.Array<Revista> ();
	}

	public void agregar ( Revista revista_nueva ) {
		Gtk.TreeIter iter;

		this.append ( out iter );
		
		this.set ( iter, 0, revista_nueva.codigo_de_barras,
		                      1, revista_nueva.nombre,
		                      2, revista_nueva.anio,
		           			  3, revista_nueva.numero,
		           			  4, revista_nueva.precio_de_venta,
		           			  5, revista_nueva.stock );
	}
 }