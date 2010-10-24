#include "cetlib/coded_exception.h"
#include <cstdlib>
#include <map>
#include <string>


using cet::coded_exception;


void
  ensure( int which, bool claim )
{
  if( not claim )
    std::exit(which);
}


enum E { E1 = 1, E2, E3, E4 };
typedef  std::map<E,std::string> Emap;

std::string
  mapper( E code )
{
  switch( code ) {
  case E1: return "E1";
  case E2: return "E2";
  case E3: return "E3";
  default: return "Unknown";
  }
}


int
  main( )
{

  {
    coded_exception<E,mapper> e(E1);
    ensure( 1, e.categoryCode() == E1 );
    ensure( 2, e.returnCode() == int(E1) );
    ensure( 3, e.category() == "E1" );
  }

  {
    coded_exception<E,mapper> e(E4);
    ensure( 11, e.categoryCode() == E4 );
    ensure( 12, e.returnCode() == int(E4) );
    ensure( 13, e.category() == "Unknown" );
  }

  return 0;

}  // main()
