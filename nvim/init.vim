let g:proj_root = fnamemodify(stdpath('config'), ':h')

call plug#begin(stdpath('config') . '/plugged')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
call plug#end()

let g:lsp_log_verbose = 1
let g:lsp_log_file = g:proj_root . '/vim-lsp.log'

let s:jdtls_root = g:proj_root . '/jdtls'
let s:jdtls_launcher = s:jdtls_root . '/plugins/org.eclipse.equinox.launcher_1.5.200.v20180922-1751.jar'
let s:jdtls_config = s:jdtls_root . '/config_win/'
let s:jdtls_data = g:proj_root . '/jdtls-data'

if executable('java')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse-jdt-ls',
        \ 'cmd': { server_info -> [
            \ 'java',
            \ '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            \ '-Dosgi.bundles.defaultStartLevel=4',
            \ '-Declipse.product=org.eclipse.jdt.ls.core.product',
            \ '-Dlog.level=ALL',
            \ '-noverify',
            \ '-Xmx1G',
            \ '-jar', s:jdtls_launcher,
            \ '-configuration', s:jdtls_config,
            \ '-data', s:jdtls_data,
            \ ]},
        \ 'whitelist': ['java'],
        \ })

        " The following cmd argument was removed because vim-lsp does not like
        " the status line the JDT language server sends regarding the debugger.
        " '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044',
endif
