#!/usr/sbin/awk -f

BEGIN {
  node_title_count = 0;
  elem_title_count = 0;
  outfile = "parsed_node_data.txt";
}

/^[[:space:]]*NODE[[:space:]]*UY.*$/ {
  if (node_title_count == 0) {
    print $0 > outfile;
    node_title_count++;
  }
}

/^[[:space:]]*ELEM[[:space:]]*F_INTERN.*$/ {
  if (elem_title_count == 0) {
    outfile = "parsed_element_data.txt";

    print $0 > outfile;
    elem_title_count++;
  }
}

/^[[:space:]]*[0-9]+[[:space:]]*-?[0-9]+.*$/ {
  # print $0 >> outfile;
  print $0;
}
