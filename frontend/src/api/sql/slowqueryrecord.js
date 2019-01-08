import axios from '../../libs/http';

const slowloglist = '/api/slowquery/slowrecordlist';

export function GetSqlList(params) {
    return axios({
        url: slowloglist,
        method: 'get',
        params
    });
}

export function GetSqlDetail(id) {
    return axios.get(slowlogget + id);
}

export function SqlAction(id, action) {
    return axios.get(inceptions + id + '/' + action);
}