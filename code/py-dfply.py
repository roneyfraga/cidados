
# https://github.com/kieferk/dfply

from dfply import *

diamonds >> head(3)

lowprice = diamonds >> head(10) >> tail(3)
lowprice

diamonds >> head(10) >> tail(3)
diamonds

# The X DataFrame symbol
diamonds >> select(X.carat, X.cut) >> head(3)

# selecting 
diamonds >> select(1, X.price, ['x', 'y']) >> head(2)
diamonds >> drop(1, X.price, ['x', 'y']) >> head(2)
diamonds >> select(~X.carat, ~X.color, ~X.clarity) >> head(2)
diamonds >> select(starts_with('c')) >> head(2)
diamonds >> select(~starts_with('c')) >> head(2)
diamonds >> drop(columns_from(X.price)) >> head(2)
diamonds >> select(columns_to(1, inclusive=True), 'depth', columns_from(-2)) >> head(2)

# Subsetting and filtering
diamonds >> row_slice([10,15])
diamonds >> group_by('cut') >> row_slice(5)
diamonds >> sample(frac=0.0001, replace=False)
diamonds >> sample(n=3, replace=True)
diamonds >> distinct(X.color)
diamonds >> mask(X.cut == 'Ideal') >> head(4)
diamonds >> mask(X.cut == 'Ideal', X.color == 'E', X.table < 55, X.price < 500)
diamonds >> filter_by(X.cut == 'Ideal', X.color == 'E', X.table < 55, X.price < 500)

(diamonds
        >> filter_by(X.cut == 'Ideal', X.color == 'E', X.table < 55, X.price < 500)
        >> pull('carat'))

# DataFrame transformation

diamonds >> mutate(x_plus_y=X.x + X.y) >> select(columns_from('x')) >> head(3)
diamonds >> mutate(x_plus_y=X.x + X.y, y_div_z=(X.y / X.z)) >> select(columns_from('x')) >> head(3)
diamonds >> transmute(x_plus_y=X.x + X.y, y_div_z=(X.y / X.z)) >> head(3)

# Grouping
(diamonds >> group_by(X.cut) >>
        mutate(price_lead=lead(X.price), price_lag=lag(X.price)) >>
        head(2) >> select(X.cut, X.price, X.price_lead, X.price_lag))

# Reshaping
diamonds >> arrange(X.table, ascending=False) >> head(5)

(diamonds >> group_by(X.cut) >> arrange(X.price) >>
        head(3) >> ungroup() >> mask(X.carat < 0.23))

diamonds >> rename(CUT=X.cut, COLOR='color') >> head(2)
diamonds >> gather('variable', 'value', ['price', 'depth','x','y','z']) >> head(5)
diamonds >> gather('variable', 'value') >> head(5)

elongated = diamonds >> gather('variable', 'value', add_id=True)
elongated >> head(5)

widened = elongated >> spread(X.variable, X.value)
widened >> head(5)

widened.dtypes

# Joining
a = pd.DataFrame({
        'x1':['A','B','C'],
        'x2':[1,2,3]
    })
b = pd.DataFrame({
    'x1':['A','B','D'],
    'x3':[True,False,True]
})

a >> inner_join(b, by='x1')
a >> outer_join(b, by='x1')
a >> left_join(b, by='x1')
a >> right_join(b, by='x1')
a >> semi_join(b, by='x1')
a >> anti_join(b, by='x1')

# Set operations
a = pd.DataFrame({
        'x1':['A','B','C'],
        'x2':[1,2,3]
    })
c = pd.DataFrame({
      'x1':['B','C','D'],
      'x2':[2,3,4]
})

a >> union(c)
a >> intersect(c)
a >> set_diff(c)

a >> bind_rows(b, join='inner')
a >> bind_rows(b, join='outer')

a >> bind_cols(b)

# Summarization
diamonds >> summarize(price_mean=X.price.mean(), price_std=X.price.std())
diamonds >> group_by('cut') >> summarize(price_mean=X.price.mean(), price_std=X.price.std())
diamonds >> summarize_each([np.mean, np.var], X.price, 'depth')
diamonds >> group_by(X.cut) >> summarize_each([np.mean, np.var], X.price, 4)

# Embedded column functions
(diamonds >> mutate(price_lead=lead(X.price, 2), price_lag=lag(X.price, 2)) >>
            select(X.price, -2, -1) >>
            head(6))

diamonds >> select(X.price) >> mutate(price_btwn=between(X.price, 330, 340)) >> head(6)
diamonds >> select(X.price) >> mutate(price_drank=dense_rank(X.price)) >> head(6)
diamonds >> select(X.price) >> mutate(price_mrank=min_rank(X.price)) >> head(6)
diamonds >> select(X.price) >> mutate(price_cumsum=cumsum(X.price)) >> head(6)
diamonds >> select(X.price) >> mutate(price_cummean=cummean(X.price)) >> head(6)
diamonds >> select(X.price) >> mutate(price_cummax=cummax(X.price)) >> head(6)
diamonds >> select(X.price) >> mutate(price_cummin=cummin(X.price)) >> head(6)
diamonds >> select(X.price) >> mutate(price_cumprod=cumprod(X.price)) >> head(6)

# Summary functions
diamonds >> group_by(X.cut) >> summarize(price_mean=mean(X.price))
diamonds >> group_by(X.cut) >> summarize(price_first=first(X.price))
diamonds >> group_by(X.cut) >> summarize(price_last=last(X.price))
diamonds >> group_by(X.cut) >> summarize(price_penultimate=nth(X.price, -2))
diamonds >> group_by(X.cut) >> summarize(price_n=n(X.price))
diamonds >> group_by(X.cut) >> summarize(price_ndistinct=n_distinct(X.price))
diamonds >> group_by(X.cut) >> summarize(price_iqr=IQR(X.price))
diamonds >> group_by(X.cut) >> summarize(price_min=colmin(X.price))
diamonds >> group_by(X.cut) >> summarize(price_max=colmax(X.price))
diamonds >> group_by(X.cut) >> summarize(price_median=median(X.price))
diamonds >> group_by(X.cut) >> summarize(price_var=var(X.price))
diamonds >> group_by(X.cut) >> summarize(price_sd=sd(X.price))

