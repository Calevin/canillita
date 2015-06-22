/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 2; tab-width: 2 -*-  */
/*
 * canillita-base-de-datos.vala
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

public class Canillita.BaseDeDatos {
  private Sqlite.Database db;
  private int rc;
  private string nombre_db;

  public BaseDeDatos ( string nombre_base_de_datos ) {
    this.nombre_db = nombre_base_de_datos;
  }

  private bool conectar () {
    var retorno = true;

    this.rc = Sqlite.Database.open ( this.nombre_db, out this.db );

    if ( this.rc != Sqlite.OK ) {
      stderr.printf ( "Could not open the data base" + ": %d, %s\n",
                      this.rc, this.db.errmsg () );
      retorno = false;
    }

    this.rc = this.db.exec ("PRAGMA foreign_keys=on", null, null);

    if ( this.rc != Sqlite.OK ) {
      stderr.printf ( "[SQL ERROR] error: %d, %s\n", this.rc, this.db.errmsg () );
    }

    return retorno;
  }

  public Array<GLib.Object> select_revistas (string tabla, string campos, string condicion = "" ) {
    this.conectar ();
    string sql_query = "SELECT " + campos + " FROM " + tabla + " " + condicion;
    Sqlite.Statement stmt;

    Array<GLib.Object> objetos = new Array<GLib.Object> ();
    string[] columnas = {"","","","","","","",""};

    this.rc = this.db.prepare_v2 ( sql_query, -1, out stmt, null );

     if ( rc == Sqlite.ERROR ) {
     stderr.printf ( "Failed to execute the query: %s -%d -%s",
                      sql_query, this.rc, this.db.errmsg () );
    }

    int cols = stmt.column_count ();
    this.rc = stmt.step ();

    while ( this.rc == Sqlite.ROW ) {
      switch ( this.rc  ) {
        case Sqlite.DONE:
          break;
        case Sqlite.ROW:
          for ( int j = 0; j < cols; j++ ) {
            columnas[j] = stmt.column_text ( j );
          }
          objetos.append_val ( this.instanciar_revista (columnas) );
          break;
        default:
          print ( "Error parsing facts");
          break;
      }

      this.rc = stmt.step ();
    }
    return objetos;
  }
  
  private GLib.Object instanciar_revista ( string [] datos ) {
    Revista revista = new Revista ();
    
    revista.id = int.parse (datos[0]);
    revista.codigo_de_barras = int.parse (datos[1]);
    revista.nombre = datos[2];
    revista.anio = int.parse (datos[3]);
    revista.numero = int.parse (datos[4]);
    revista.precio_de_compra = (float) double.parse (datos[5]);
    revista.precio_de_venta = (float) double.parse (datos[6]);
    revista.stock = int.parse (datos[7]);

    return revista as GLib.Object;
  }
}
