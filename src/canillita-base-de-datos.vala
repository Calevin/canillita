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

  private static bool conectar ( out Sqlite.Database db ) {
    bool retorno = true;

    int rc = Sqlite.Database.open ( "canillita.db", out db );

    if ( rc != Sqlite.OK ) {
      stderr.printf ( "Could not open the data base" + ": %d, %s\n",
                      rc, db.errmsg () );
      retorno = false;
    }

    rc = db.exec ( "PRAGMA foreign_keys=on", null, null );

    if ( rc != Sqlite.OK ) {
      stderr.printf ( "[SQL ERROR] error: %d, %s\n", rc, db.errmsg () );
    }

    return retorno;
  }

  public static Array<GLib.Object> select ( string tabla, string campos, string condicion = "" ) {
    Sqlite.Database db;
    int rc;

    Array<GLib.Object> objetos = new Array<GLib.Object> ();

    if ( BaseDeDatos.conectar ( out db ) ) {
      string sql_query = "SELECT " + campos + " FROM " + tabla + BaseDeDatos.armar_condicion ( condicion );
      Sqlite.Statement stmt;

      string[] columnas = {"","","","","","","",""};

      rc = db.prepare_v2 ( sql_query, -1, out stmt, null );

      if ( rc == Sqlite.ERROR ) {
        stderr.printf ( "Failed to execute the query: %s -%d -%s",
                        sql_query, rc, db.errmsg () );
      }

      int cols = stmt.column_count ();

      do {
        rc = stmt.step ();
        switch ( rc  ) {
          case Sqlite.DONE:
            break;
          case Sqlite.ROW:
            for ( int j = 0; j < cols; j++ ) {
              columnas[j] = stmt.column_text ( j );
            }
            objetos.append_val ( BaseDeDatos.instanciar_revista (columnas) );
            break;
          default:
            print ( "Error parseando revistas" );
            break;
        }
      } while ( rc == Sqlite.ROW );
    }
    
    return objetos;
  }

  private static GLib.Object instanciar_revista ( string [] datos ) {
    Revista revista = new Revista ();

    revista.id = int.parse ( datos[0] );
    revista.codigo_de_barras = int.parse ( datos[1] );
    revista.nombre = datos[2];
    revista.anio = int.parse ( datos[3] );
    revista.numero = int.parse ( datos[4] );
    revista.precio_de_compra = (float) double.parse ( datos[5] );
    revista.precio_de_venta = (float) double.parse ( datos[6] );
    revista.stock = int.parse ( datos[7] );

    return revista as GLib.Object;
  }

  private static string armar_condicion ( string condicion ) {
    string retorno = "";
    if ( condicion != "" ) {
      retorno = " WHERE " + condicion;
    }
    return retorno;
  }
}
