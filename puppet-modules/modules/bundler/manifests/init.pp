class bundler {
  package{'bundler':
    ensure   => present,
    provider => gem,
  }     
}     
