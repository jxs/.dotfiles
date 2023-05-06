return {
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    keys = {
      { '<leader>f', '<cmd>GFiles -c --others --exclude-standard<cr>' },
      { '<leader>e', '<cmd>FZFExplore<cr>' },
      { '<leader>l', '<cmd>Rgz<cr>' },
      { '<leader>b', '<cmd>Buffers<cr>' },
    },
    init = function()
      vim.g.fzf_layout = { down = '30%' }

      -- Search pattern across repository files
      vim.cmd [[
        function! RgFzf(...)
          let input = input('Enter expression: ')
          let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
          let rg_command = printf("rg --column --line-number --no-heading --color=always --fixed-strings '%s' %s", input, git_root)
          call fzf#vim#grep(rg_command, 1, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}))
        endfunction
        command! -bang -nargs=* Rgz call RgFzf(shellescape(<q-args>), {}, <bang>0)
      ]]

      -- Search pattern across repository files
      vim.cmd [[
        let s:current_path = ""
        function! FzfExplore(...)
          let inpath = substitute(a:1, "'", '', 'g')
          let s:current_path = inpath == "" ? expand('%:p:h') : s:current_path
          if inpath == "" || matchend(inpath, '/') == strlen(inpath)
            let s:current_path .= '/' . inpath
            let prompt = fnamemodify(s:current_path, ":p")
            call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'ls -1ap', 'dir': s:current_path, 'sink': 'FZFExplore', 'options': ['--prompt', prompt]})))
          else
            let path = s:current_path . '/' . inpath
            execute "e" inpath
          endif
        endfunction
        command! -nargs=* FZFExplore call FzfExplore(shellescape(<q-args>))
      ]]
    end,
  }
}
