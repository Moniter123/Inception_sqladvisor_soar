import axios from '../../libs/http';

const slowloglist = '/api/slowquery/slowloglist';

export function GetSqlList(params) {
    return axios({
        url: slowloglist,
        method: 'get',
        params
    });
}

export function GetSlowDetail(id) {
    return axios.get('/api/slowquery/detail/get?id=' + id);
}

export function GetUsers() {
    return axios.get('/api/slowquery/slowlog/users');
}