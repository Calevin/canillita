/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * main.c
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
using Gtk;

public class Canillita.ListStoreVentas : Gtk.ListStore {
        public ListStoreVentas () {
			Type [] tipos_columnas = { typeof(uint64), typeof(string), typeof(float), typeof(int) };

			this.set_column_types ( tipos_columnas );
		}
}
