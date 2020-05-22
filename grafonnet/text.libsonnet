{
  /**
   * @name text.new
   */
  new(
    title='',
    height=null,
    width=null,
    mode='markdown',
    content='',
    transparent=null,
    description=null,
    datasource=null,
  )::
    {
      [if transparent != null then 'transparent']: transparent,
      title: title,
      gridPos: {
        h: height,
        w: width
      },
      type: 'text',
      mode: mode,
      content: content,
      [if description != null then 'description']: description,
      datasource: datasource,
    },
}
