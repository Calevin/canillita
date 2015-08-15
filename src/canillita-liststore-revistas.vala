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
using GLib;

public class Canillita.ListStoreRevistas : Gtk.ListStore {
  private Array<Revista> revistas;

  public ListStoreRevistas () {

    Type[] tipos = { typeof(uint64),
                     typeof(string),
                     typeof(string),
                     typeof(Revista)
                  , };
    this.set_column_types ( tipos );

    this.revistas = new Array<Revista> ();
  }
// Este es le método que se va a usar para carcar el liststore
  public void agregar_revistas ( Array<Revista> revistas_nuevas ) {
    // se fija si el array del parámetro no está vacío.
    if ( revistas_nuevas.length > 0 ) {
      //agrega los items del array al liststore
      for ( int i = 0; i < revistas_nuevas.length; i++ ) {
        this.agregar ( revistas_nuevas.index (i) );
      }
      //resetea el array interno.
      this.revistas = new Array<Revista> ();
      //carga el array interno con los nuevo ítmes del array del parámetro.
      for ( int i = 0; i < revistas_nuevas.length; i++ ) {
        this.revistas.append_val ( revistas_nuevas.index (i) );
      }
      //elimina las filas del liststore que no estaban en el array del parámentro.
      this.eliminar_sobrantes ();

    } else {
      //Si el array del parámetro está vacío limpia el liststore y el array interno.
      this.clear ();
      this.revistas = new Array<Revista> ();
    }
  }

  //Se fija si ese ítem ya está agregado en el liststore, si no lo agrega.
  private void agregar ( Revista revista_nueva ) {
    Gtk.TreeIter iter;

    if ( !(this.ya_agregado ( revista_nueva )) ) {
      this.append ( out iter );
      this.set ( iter, 0, revista_nueva.codigo_de_barras,
                       1, revista_nueva.nombre,
                       2, revista_nueva.descripcion,
                       3, revista_nueva );
    }
  }

  //Devuelve true si el item ya está en el liststore
  private bool ya_agregado ( Revista revista_nueva ) {
    bool resultado = false;

    for (int i = 0; i < this.revistas.length; i++ ) {
      if ( this.revistas.index (i).id == revista_nueva.id ) {
        resultado = true;
        break;
      }
    }

    return resultado;
  }

  //Se fija si el ítem está en el array interno.
  private bool sobra ( Revista sobrante ) {
    bool de_mas = true;

    for ( int i = 0; i < this.revistas.length; i++ ) {
      if ( this.revistas.index (i).id == sobrante.id ) {
        de_mas = false;
        break;
      }
    }

    return de_mas;
  }

  //Elimina los ítems que estén en el liststore pero no en el array interno.
  private void eliminar_sobrantes () {
    Gtk.TreeIter iter;
    Value value_revista;
    Revista revista;
    bool flag = true;

    if ( this.get_iter_first ( out iter ) ) {
      do {
        this.get_value ( iter, 7, out value_revista );
        revista = value_revista as Revista;

        if ( this.sobra ( revista ) ) {
          this.remove (iter);
          flag = this.get_iter_first ( out iter );
        } else {
          flag = this.iter_next ( ref iter );
        }
      } while ( flag );
    }
  }
}
