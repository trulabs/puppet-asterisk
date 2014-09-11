#nodes.pp

node 'YOURHOSTNAMEHERE' {

  class { '::asterisk':
  }
}
