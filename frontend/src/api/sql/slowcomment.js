import axios from '../../libs/http';

const sloworderlist = '/api/slowquery/slowcommentlist';

export function GetSlowList(params) {
    return axios({
        url: sloworderlist,
        method: 'get',
        params
    });
}

export function Putdata(data){
	return axios({
        url: sloworderlist + '/',
        method: 'post',
        data: data
    });
}

export function GetSqlDetail(id) {
    return axios.get(slowlogget + id);
}

export function SqlAction(id, action) {
    return axios.get(inceptions + id + '/' + action);
}