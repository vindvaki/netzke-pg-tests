describe 'Authors', ->
  it 'should not show the same record on two different pages', (done) ->
    wait ->
      grid = Ext.ComponentQuery.query('panel[id="authors"]')[0]
      grid.columns[0].show()
      store = grid.getStore()
      records = []
      current = 0
      total = store.getTotalCount()
      do iter = ->
        if current < total
          for i in [0..(store.data.getCount()-1)]
            records.push(store.data.getAt(i))
          current += store.data.getCount()
          store.nextPage()
          wait(iter)
        else
          ids = Ext.Array.sort(Ext.Array.unique(records.map((r) -> r.data.id)))
          expect(Ext.Array.difference([1..store.getTotalCount()], ids)).to.eql []
          # expect(ids).to.eql store.getTotalCount()
          done()
